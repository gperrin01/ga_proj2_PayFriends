Calcualte the balance between 2 users
    choice 1) iterates through all database and look for transactions with those 2 guys
    choice 2) have an object (join table?) user1_user2 that is updated each time there is a transaction
        2) seems better for perf
       2) implies slight chagnge of my tests when checking recap_balance

User has many balances, Balance belongs to 1 User
user1.Balances
  user2  10
  user5  35
Balance object is indexed using the id of all the other users

# DO I EVEN NEED TO TEST FOR THE FULLL BALANCES GIVEN THEY ARE JUST THE SUMS OF CROSS BALANCES???


To ensure settled transactions are not taken into account anymore, 
Good way to have a type of transactions where settled = true, 
and we run all functions .to_pay, .to_receive, .recap_balacnce only on arrays of settled trnsactions



Feature is to by default show the 5/10 latest transactions or ones with biggest amount
ex of coding it:
  - get array of all balance recaps, orderer DESC
  - slice it to return the first 10, and iterate over that -   array.slice(xyz).each, ensuring what is returned is the top 10
