<%@ page import="java.util.*, java.io.*, java.text.*, java.lang.*, java.lang.reflect.*"
%><%@ include file="utility.jsp"
%><%
	File folder = new File("C:/Users/Duc.Nguyen/Desktop/Developer/data");
	try {
		FileName[] fileList = ListFilesInFolder(folder);
		out.println(toJson(fileList));
		
	} catch (Exception e){
		out.println(e.toString());
	}
	
%><%!
	public class FileName {
		public String type 		= null;
		public String accountId = null;
		public String entityId	= null;
		public String timeStamp	= null;
		public String name		= null;
	}
	
	
	
	 public FileName[] ListFilesInFolder(File folder){
        List<FileName>fileList = new ArrayList<FileName>();
        for(File file : folder.listFiles()){
            if(file.isDirectory()){
                ListFilesInFolder(file);
            } else {
                if(file.getName().charAt(0)=='w'){
                    FileName name = new FileName();
                    String [] temp = file.getName().split("[-.]");
                    name.type = temp[0];
                    name.accountId = temp[1];
                    name.entityId = temp[2];
                    name.timeStamp = ToDate(Long.parseLong(temp[3]));
                    name.name = file.getName();
                    fileList.add(name);
                }
            }
        }
		
		FileName[] fileArr = fileList.toArray(new FileName[fileList.size()]);
        return fileArr;
    }
	
	  public String ToDate(long milsec){
        Date date = new Date(milsec);
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss a");

        return df.format(date);
    }
%>