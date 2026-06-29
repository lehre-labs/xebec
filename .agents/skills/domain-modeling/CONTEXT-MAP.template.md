# Context Map

{agent-write: One or two sentence description of what this context map is and why it exists.}

## Contexts

- [{agent-write: The Term}]({agent-write: The Path to the CONTEXT.md}) -- {agent-write: The one-line description of the context}

<context-example>
- [Ordering](./src/ordering/CONTEXT.md) -- receives and tracks customer orders
- [Billing](./src/billing/CONTEXT.md) -- generates invoices and processes payments
- [Fulfillment](./src/fulfillment/CONTEXT.md) -- manages warehouse picking and shipping
</context-example>

## Relationships

- **{agent-write: Term A} → {agent-write: Term B}**: {agent-write: Term A doing something}; {agent-write: Term B doing something else}

<relationship-example>
- **Ordering → Fulfillment**: Ordering emits `OrderPlaced` events; Fulfillment consumes them to start picking
- **Fulfillment → Billing**: Fulfillment emits `ShipmentDispatched` events; Billing consumes them to generate invoices
- **Ordering ↔ Billing**: Shared types for `CustomerId` and `Money`
</relationship-example>

<critical>
- Only include terms specific to this project's context. General programming concepts (timeouts, error types, utility patterns) don't belong even if the project uses them extensively. Before adding a term, ask: is this a concept unique to this context, or a general programming concept? Only the former belongs.
- Group terms under subheadings when natural clusters emerge. If all terms belong to a single cohesive area, a flat list is fine.
</critical>
