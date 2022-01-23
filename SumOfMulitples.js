

    const SumOfMultiples = (multiples, limit) => [...Array(limit)].map((_, idx) => idx).filter(num => multiples.map(m => num % m).includes(0)).reduce((acc, val) => acc += val, 0)

//constant contents can be manipulated. the structure cannot be changed. passing in multiples and limit. arrow function. variatic function meaning any number of arguments. in java it is array spread syntax. mapping allows you to delcare a function and run that function on an array. filter out multiples that double up. 
