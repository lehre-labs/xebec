# {agent-write: Short title for context file}

{agent-write: One or two sentence description of what this context is and why it exists.}

## Language

**{agent-write: The Term}**
{agent-write: A one or two sentence description of the term (definition)}
_Avoid_: {agent-write: Similar terms separated by commas}

<language-example>
**Order**:
An order is a request for a product or service from a customer.
_Avoid_: Purchase, Transaction
</language-example>

<language-example>
**Invoice**:
A request for payment sent to a customer after delivery.
_Avoid_: Bill, Payment Request
</language-example>

<language-example>
**Customer**:
A person or organization that places orders.
_Avoid_: Client, Buyer, Account, User
</language-example>

<critical>
- Be opinionated. When multiple words exist for the same concept, pick the best one and list the others under _Avoid_.
- Keep definitions tight. One or two sentences max. Define what it IS, not what it does.
- Only include terms specific to this project's context. General programming concepts (timeouts, error types, utility patterns) don't belong even if the project uses them extensively. Before adding a term, ask: is this a concept unique to this context, or a general programming concept? Only the former belongs.
- Group terms under subheadings when natural clusters emerge. If all terms belong to a single cohesive area, a flat list is fine.
</critical>
