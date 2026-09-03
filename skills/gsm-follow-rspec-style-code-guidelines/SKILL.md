---
name: gsm-follow-rspec-style-code-guidelines
description: Invoke when writing tests in RSpec-style format
user_invocable: true
---

# GSM > Follow > RSpec-style Code Guidelines

## Goal

- Structure and write tests in an RSpec-style format according to specific conventions.

## Guidelines

### `describe` blocks

- Organize tests around public entry points.
  - Use `describe "#method_name"` for instance methods (e.g., `#valid?`, `#destroy`).
  - Use `describe ".method_name"` (or `describe "#self.method_name"`) for class methods.
    - Why: Ties the test structure directly to the API under test.

- Group tests conceptually under the method block.
  - Use `describe "concerning ..."` for sub-groupings (e.g., validation topics, lifecycle side effects).

### `context` blocks

- Axis of variation:
  - Use `context "when ..."` to describe specific conditions or variations.

- Scope of setup (`let`, `let!`, `before`):
  - Place setup code directly under the `context` that it makes true.
    - Avoid putting setup in distant ancestor blocks unless they are genuinely shared.
    - Why: Readers should be able to see immediately under the `context` header how the state matches the description.

  - Use outer contexts to own shared, baseline machinery (e.g., subjects, accounts, general records).

  - Use parameterised helper `let` definitions in the parent context to DRY up record instantiations:
    - Define default attributes for the record under test as helper `let` definitions in the parent block.
    - Instantiate the record once using a parent `let!` block referencing these helper attributes.
    - In child `context` blocks, override only the specific helper `let` attributes that change. Avoid using nested `before` blocks that create duplicate or additional records.
    - Why: Avoids redundant setup, makes variations declarative, and keeps them easy to scan.
    - Ensure all helper `let` parameters referenced in the `let!` block are defined with a default value in the parent block. This prevents child contexts that don't override them from raising `NameError`.

  - Prefer explicitly declaring setup state inside sibling contexts:
    - Define the relevant helper `let` parameters explicitly in each context block, instead of implicitly assuming or relying on the parent context's default state.
      - Example: Under `context "when the lead belongs to the account"`, specify `let(:lead_account_id) { account.id }` even if it matches the parent's default.
      - Why: Makes nested context blocks contrasting, self-documenting, and resilient to future changes in parent block defaults.

  - Context Naming Coherence:
    - Keep outer context descriptions broad enough to cover all variations in their nested child contexts. Avoid naming parent contexts with constraints that are contradicted by their children.
      - Example: Name the parent context `"when the vendor has a single lead"` instead of `"when the vendor has a lead in the past 14 days"` if a child context overrides the date to be older than 14 days.
      - Why: Prevents logical contradictions between parent and child contexts, making the test suite easy to read and maintain.

### `it` blocks

- Single responsibility:
  - Each `it` block should verify exactly one behavioral claim.
  - Keep the test body tight (ideally a single assertion or a short sequence representing one claim).

- Shared vocabulary:
  - Align the description string with the test body variables and actors.
    - Example: If the description refers to the "second telemarketer", the assertion should reference `telemarketers[1]`.

- Self-explanatory descriptions:
  - Ensure test descriptions are self-contained and clear, without referencing arbitrary mock data, setup indices, or internal mock labels (e.g., `(Order A, B)`, `(Scenario 1)`).
  - Describe the business rule, expected behavior, or sorting criteria directly.
    - Bad: `it "sorts by auto_leads_count descending (Order A, B)"`
    - Good: `it "sorts by auto_leads_count descending"`

## Sample Code

Below is an example illustrating the use of parameterised `let` setups to DRY up variations of a single record's state:

```ruby
class LeadOriginPerformanceQueryTest < ActiveSupport::TestCase
  let(:account) { create(:organization) }
  let(:source) { create(:lead_source, account: account) }

  subject { LeadIq::LeadOriginPerformanceQuery.new(account: account) }

  describe "#call" do
    context "when there is a single lead" do
      # Default attributes for the record under test
      let(:lead_account_id) { account.id }
      let(:lead_source) { source }
      let(:lead_cost) { 10 }
      let(:lead_landing_page_url) { "https://example.com" }
      let(:lead_sub_1) { nil }

      # Single instantiation for all nested variations
      let!(:lead) do
        create(:lead,
          landing_page_url: lead_landing_page_url,
          sub_1: lead_sub_1,
          account_id: lead_account_id,
          lead_source: lead_source,
          cost: lead_cost)
      end

      describe "concerning the account" do
        context "when the lead does not belong to the account" do
          let(:lead_account_id) { create(:organization).id }

          it "is empty" do
            assert_empty subject.call
          end
        end

        context "when the lead belongs to the account" do
          # Prefer explicitly implementing each context instead of implicitly assuming the state of the parent context
          let(:lead_account_id) { account.id }

          it "can include the lead origin" do
            assert_equal 1, subject.call.to_a.size
            assert_equal "https://example.com", subject.call.first.origin_identifier
          end
        end
      end

      describe "concerning lead cost" do
        context "when the lead cost is 0" do
          let(:lead_cost) { 0 }

          it "is empty" do
            assert_empty subject.call
          end
        end
      end

      describe "concerning origin" do
        context "when the lead does not have an origin" do
          let(:lead_landing_page_url) { "" }

          it "is empty" do
            assert_empty subject.call
          end
        end

        context "when the lead has an origin" do
          let(:lead_landing_page_url) { "" }
          let(:lead_sub_1) { "sub_123" }

          it "can include the lead origin" do
            assert_equal 1, subject.call.to_a.size
            assert_equal "sub_123", subject.call.first.origin_identifier
          end
        end
      end
    end
  end
end
```
