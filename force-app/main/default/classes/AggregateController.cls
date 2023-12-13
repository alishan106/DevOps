public class AggregateController {
	//	select count() from account
	//	select count(rating) from account
	//	select count(phone) from account
	
	//	select count(id),rating from account group by rating
    public List<AggregateResult> accountAggregateList {get;set;}
    public List<AggregateResult> oppAggregateList {get;set;}
    public AggregateController(){
        //	expr0
        accountAggregateList = [select count(id),rating from account where rating = 'Hot' group by rating];  
        
        //	accountAggregateList = [select count(id) total,rating from account group by rating];
        
        //	accountAggregateList = [select count(id),rating from account where rating = 'Hot' group by rating];
        
        
        oppAggregateList = [select count(id), sum(amount), min(amount) minimumAmount, max(amount), avg(amount), StageName from opportunity group by StageName];
        
        for(AggregateResult oppAggregate : oppAggregateList){
			Integer count = (Integer) oppAggregate.get('expr0');
            Decimal amount = (Decimal) oppAggregate.get('expr1');
            System.debug('@@ '+count+' \t'+amount);
        }
    }
}