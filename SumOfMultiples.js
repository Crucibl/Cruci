export default function SumOfMultiples (multiples, limit)   {
    var total = 0;
    // run  a loop the same number of times as my limit. If my limit is 10 I run 10 times. First I declare a variable or iterator. Then set up conditional 
    for (var i = 0;i < limit; i++) { 
// nest another for loop for as many items as are in multiples array
         for (var x = 0; x < multiples.length; x++) {
             if (i % multiples[x] === 0) {
                 total += i;
                 break;
// break allows you to exit loop once condition is met

              }
        }

   // check each number individual


   // length gives number of items in array


    }
return total
}