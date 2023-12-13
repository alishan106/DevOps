public class ContactPaginnationController {
    
    public Integer totalRecs{get;set;}
    public Integer offsetSize {get;set;}
    public Integer limitSize {get;set;}
    public Integer btnNum {get;set;}
    public List<Integer> btnNumber {get;set;}
    public List<SelectOption> selectList;
    
    public ContactPaginnationController()
    {
        limitSize = 5;
        OffsetSize = 0;
        totalRecs = [select count() from contact];
        
    }
    public List<contact> getcontactList()
    {
		Integer btnsize = (Integer)math.ceil(totalRecs/limitSize);
        btnNumber = new List<Integer>();
        if(math.mod(totalRecs,limitSize)!=0){
            btnsize+=1;
        }
        for(Integer i=1;i<=btnsize;i++){
            if(i<=10){
                btnNumber.add(i);
            }
            else{
                break;
            }
        }        
        List<contact> contactList = Database.Query('SELECT Name, LastName, email, phone from contact limit :limitSize OFFSET : offsetSize');
        
        return contactList;
    }
    
    public List<SelectOption> getselectList(){
        
        selectList = new List<SelectOption>();
        selectList.add(new SelectOption('0','All'));
        selectList.add(new SelectOption('5','5'));
        selectList.add(new SelectOption('10','10'));
        selectList.add(new SelectOption('20','20'));
        selectList.add(new SelectOption('50','50'));
        selectList.add(new SelectOption('100','100'));
        
        return selectList;
    }
    
    public void refreshPageSize() {
        
        OffsetSize = 0;
        if(limitSize==0){
            limitSize= totalRecs;
            System.debug('limitSize '+limitSize);
        }
    }
    
    public void FirstPage()
    {
        offsetSize = 0;
    }
    public void previous()
    {
        offsetSize = OffsetSize - limitSize;
        
    }public void next(){
        
        offsetSize += limitSize ;
        
    }public void LastPage(){
        offsetSize = totalrecs - math.mod(totalrecs,limitSize);
    }
    public boolean getprev(){
        if(OffsetSize == 0)
            return true;
        else
            return false;
    }
    public boolean getnxt(){
        if((OffsetSize + limitSize) >= totalrecs)
            return true;
        else
            return false;
    }
    public void pageChange(){
      if(limitSize==0)
      {
      limitSize= totalRecs;
      }
        else{
             offsetSize = (btnNum * limitSize)-limitSize;
        }
    }

}