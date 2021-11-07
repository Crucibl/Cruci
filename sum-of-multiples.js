export const sum = (array, limit) => {
    
      let sum=0;
    
    
      for(let i=0; i<limit; i++){
    
        if(array[i] != 0 && array.some((value)=> i % value ===0)){
    
          sum +=i;
    
        }
    
      }
    
    
      return sum;
    
      
    
    };