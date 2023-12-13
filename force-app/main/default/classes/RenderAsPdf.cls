public class RenderAsPdf {

    @Future(callout=true)
    public static void renderMethod(String recordId){
        	PageReference PDf =  Page.submittalDocumentVF;//Replace attachmentPDf with the page you have rendered as PDF
            PDf.setRedirect(true);
            Attachment attach = new Attachment();
            Blob b ;
            b = PDf.getContent();
            attach.Body = b;
            attach.Name = 'E-HealthJobs Submittal 3.pdf';
            attach.IsPrivate = false;
            attach.ParentId = recordId;
            insert attach;
    }
}