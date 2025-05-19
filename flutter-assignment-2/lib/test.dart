void main() {

  List<int> ratings = [1,2,2];
  int n = ratings.length;
  int candies = n;
  int current = 0;
  if(n == 1) print(1);
  for(int i=1;i<n;i++){

    if(ratings[i]!=0){
      if(ratings[i] > ratings[i-1]){
        current++;
        candies+=current;
      }else{
        current--;
        candies+=current;
      }


    }


  }
 print(candies);

}
