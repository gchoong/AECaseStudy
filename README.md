# Section 1

## FEC Dataset

- Donation level data grain

- I would break up the sub queries into CTE's. Also would be good to have staging models for these tables. It would be easier to reuse That is why I went ahead and made staging tables for both the individual and candidates

  

## Assumptions

Most of the time, assumptions are going to be in the filters and joins and the calculations.

- The fact that it's an inner join means there is potential for donations we are missing simply because they didn't have a candidate_pcc. Are we always going to have a candidate_pcc? After a quick check. Yeah, there are some nulls in the pcc thus missing some possible donations and creating inaccurate data.

- the unique_donor calculation doesn't account for if there are two different people, but with the exact name and zip code. (Imagine if there were 2 John Smiths or Jane Doe's in the same area code. Are they actually distinct donors?)

- The donation count can also be different just because of the type of join that we use. Need to re-evaluate the grain of the data. Probably also better to just use the transaction_id for the count instead of doing a *. What work was done to double check if there were any duplicate transaction_id's? Uniqueness tests are pretty key.

- There are also donations that have an amount of 0, Probably not great to count those unless it's in <1 dollar amounts

- Is Transaction ID also one donation? Can there be multiple tran_id for what we count as one donation? or is it truly multiple donations.

- I also confirmed that in the individual table, there are also duplicates in the data. e.g. tran_id 4753483.

- There are also - donations, do we want to count those as donations?!

  

# Section 2

  

- Even with carefully considered code, this dataset can’t produce a perfect reflection of these candidates’ donors. Draft a short paragraph describing the dashboard’s limitations, to be included alongside the dashboard itself.

    - In terms of dashboard limitations, I would talk about source freshness and the data refresh limitations. I would also talk about the dashboard in the current iteration not taking into account if the donation has been bounced. As we saw in the initial walkthrough of the data. I will need to talk to the stakeholder on how to best proceed.

  

- Now, it’s time to deliver it to our users! In a few sentences, concretely describe your strategy to get this data product into users’ hands in an accessible, approachable format.

    - Usually I would let people know it's availabe in BigQuery, give some generic use cases, basically repeat the requirements met and the use cases. But since I'm also the BI person and needing to make the dashboard, I would share the link to stakeholders and explain the above.

  

- While our initial product was built toward specific user requirements, we believe other teams could also derive actionable outcomes from this FEC data. Think of another audience who could benefit from this data, and describe how you’d adapt the product to their needs in a short paragraph. Include considerations you might take toward scalability or solving for different user profiles.

    - On initial look. I just don't understand politics all too much to figure out what stakeholder would benefit, but I can take a guess for State by state democrat groups that we can let them know voter and funding outreach. Since we also know their location, maybe we can match that up in terms of voter socio-economic status to tailor messaging strategy? For example,