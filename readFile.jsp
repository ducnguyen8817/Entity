<%@ page import="java.util.*, java.io.*, java.text.*, java.lang.*, java.lang.reflect.*"
%><%@ include file="utility.jsp"
%><%
	String fileName = nvl(request.getParameter("savepoint"));
	String path = "C:/Users/Duc.Nguyen/Desktop/Developer/data/";
	String fullPath = path.concat(fileName);
	try {
		FieldName[] fields = readFile(fullPath);
		out.println(toJson(fields));
	} catch (Exception e){
		out.println (e.toString());
	}
%><%!

public class FieldName {
	public String fieldName	= null;
	public String value			= null;
}

public FieldName[] readFile(String path) throws  Exception{
	List<FieldName> fields = new ArrayList<FieldName>();
	FieldName  field = null;
	BufferedReader br = null;
	
	try {
		String currentLine;
		br = new BufferedReader(new FileReader(path));
		while((currentLine = br.readLine())!=null ){
			if(currentLine.charAt(0)!='#') {
				field = new FieldName();
				String [] temp = currentLine.split("=");
				if(temp.length ==1){
					field.fieldName = temp[0];
					field.value="";
				}
				if(temp.length==2){
					field.fieldName = temp[0];
					field.value = temp[1];
				}
				fields.add(field);
			}
		}		

	} catch (Exception e) {
		throw e;
	}
	
	FieldName [] fieldArr = fields.toArray(new FieldName[fields.size()]);
	return fieldArr;   	
}
%>