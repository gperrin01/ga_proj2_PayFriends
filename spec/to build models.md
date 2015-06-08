
# DO I EVEN NEED TO TEST FOR THE FULLL BALANCES GIVEN THEY ARE JUST THE SUMS OF CROSS BALANCES???


Feature is to by default show the 5/10 latest transactions or ones with biggest amount
ex of coding it:
  - get array of all balance recaps, orderer DESC
  - slice it to return the first 10, and iterate over that -   array.slice(xyz).each, ensuring what is returned is the top 10
