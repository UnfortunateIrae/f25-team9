# Customizable Newsletter Requirements Testing
## Actors
- Customer (the user with the customer role)
- Writer/Provider (the user with the writer/provider role)
- SysAdmin (the user with the admin role if applicable)

### Use Cases
#### 1. Writer: Create writer profile use case:
1. Writer W1 logs in for the first time and creates a profile.
2. W1 creates new topics T1 and T2 with articles A1, A2, A3.  
W1 exits the app.

#### 2. Customer: Create customer profile:
1. Customer C1 logs in for the first time and creates a profile.
2. C1 selects their topics of interest based on categories and tags.

#### 3. Customer: View and subscribe to topics:
1. Customer C2 logs in for the first time and creates a new profile.
2. C2 views available topics T1 and T2.
3. C2 subscribes to T1 to receive weekly email newsletters.

#### 4. Customer: Write review
1. C2 logs in and views their subscriptions.
2. C2 reads an article from T1 and writes a positive review with a star rating.
3. C2 exits.

#### 5. Customer: Modify profile
1. C1 logs in and modifies their profile preferences.
2. C1 views topic T1, reads articles, and sees the positive review.
3. C1 subscribes to T1 to receive weekly newsletter updates. C1 exits.

#### 6. Writer: Reply to Review, View Customer Statistics, & Modify Profile use cases
1. Writer W1 logs in and reads customer reviews on their articles and replies with thanks. 
2. W1 views customer statistics and topic ratings.
3. W1 modifies their profile and creates a new article. W1 exits.