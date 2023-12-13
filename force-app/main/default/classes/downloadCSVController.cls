public class downloadCSVController {
    
    public static PageReference DownloadCSV(){
        
        List<Account > acclist = [Select id,name , CreatedDate , lastModifiedDate from Account limit 10];
        string header = 'Record Id, Name , Created Date, Modified Date \n';
        string finalstr = header ;
        for(Account a: acclist)
        {
            string recordString = '"'+a.id+'","'+a.Name+'","'+a.CreatedDate+'","'+a.LastModifiedDate +'"\n';
            finalstr = finalstr +recordString;
        }
        Document o = new Document(
            FolderId = UserInfo.getUserId(),
            Name = 'Account.csv',
            Body = Blob.valueOf(finalstr )
        );
        insert o;
        return new PageReference('/servlet/servlet.FileDownload?file=' + o.Id);
        
    }
    
}