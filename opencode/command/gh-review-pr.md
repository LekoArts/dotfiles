# Review Pull Request

Use the GH CLI to analyze and summarize a pull request for the current repository.
The current branch is checked out in the same branch as the PR.

RUN gh pr view --json title,body,commits,files,labels,assignees,reviews,comments,statusCheckRollup

## Review Process

### Stage 1: Understand the Context
1. Read the PR title and description carefully
2. Check linked issues (if any) using `gh issue view`
3. Review the commit history to understand the progression of changes
4. Note any labels, assignees, and check status

### Stage 2: Analyze the Code
1. List all changed files using `gh pr diff`
2. Create a PR_SUMMARY.md file in the project root with sections for:
   - **Overview**: What this PR accomplishes
   - **How It Works**: Technical explanation of the implementation
   - **Key Changes**: File-by-file breakdown with links (use format: `path/to/file.ts:line`)
   - **Architecture Impact**: How this fits into the overall system
   - **Dependencies**: Any new dependencies or APIs introduced
   - **Testing**: What tests cover these changes
   - **Potential Concerns**: Any risks or areas that need attention

3. For each significant file change:
   - Understand the context and purpose
   - Explain the logic flow and implementation details
   - Note how it connects to other parts of the codebase
   - Identify any patterns or conventions used
   - Link to specific lines for important code sections

### Stage 3: Deep Dive
1. Trace through the code execution path
2. Understand the data flow and transformations
3. Check how edge cases are handled
4. Verify integration points with existing code
5. Document your understanding in the summary file

### Stage 4: Present to User
1. Complete the PR_SUMMARY.md with a comprehensive explanation
2. Use clear, technical language to explain how the code works
3. Include helpful diagrams or examples if complex logic is involved
4. Link to specific files and line numbers for easy navigation
5. Highlight any interesting design decisions or trade-offs

## Summary Structure Example

```markdown
# PR Summary: [PR Title]

## Overview
Brief description of what this PR achieves and why it's needed.

## How It Works
Technical explanation of the solution approach and implementation strategy.

## Key Changes

### Modified Files
- `src/services/auth.ts:45-67` - Added new authentication middleware
- `src/utils/validation.ts:12-34` - Enhanced input validation logic
- `tests/auth.test.ts:89-120` - New test cases for auth flow

### New Files
- `src/middleware/rateLimit.ts` - Implements rate limiting functionality

## Architecture Impact
How these changes fit into and affect the overall system architecture.

## Dependencies
- Added `express-rate-limit` for rate limiting
- Updated `jsonwebtoken` to v9.0.0

## Testing
- Unit tests in `tests/auth.test.ts`
- Integration tests in `tests/integration/auth.spec.ts`
- All existing tests still pass

## Potential Concerns
- Performance impact of additional middleware
- Migration needed for existing tokens
```

Remember: The goal is to help the user fully understand the PR's implementation and impact, focusing on explaining how the code works rather than critiquing it.
