<%@ page import="java.util.*, java.sql.*,tnt3.*, java.lang.*, act.util.*, java.lang.reflect.*"
%><%@ include file="utility.jsp"
%><%
	DeleteStatus [] statuses = null;
	String accountId 	= nvl(request.getParameter("account"));
	String entityId  	= nvl(request.getParameter("entity"));
	
	
	try {
		statuses = getDeleteStatus(accountId, entityId);
		out.println(toJson(statuses));
	} catch (Exception e){
		out.println (e.toString());
	}
	
%><%!
	
	public class DeleteStatus{
		public String name;
		public String year;
		public String status;
	}
	
	public DeleteStatus[] getDeleteStatus(String accountId, String entityId) throws Exception{
		String dataSource     = "jdbc/development";
		
		Connection 	 		conn		= null;
		PreparedStatement	ps 			= null;
		ResultSet			rs			= null;
		
		List<DeleteStatus> statuses = new ArrayList<DeleteStatus>();
		DeleteStatus 		status	= null;
		
		try {
			conn =  DBConnection.openConnection(dataSource);
			try {
				ps = conn.prepareStatement("select name, year, inactive"
										  +" from tnt_entity"
										  +" where accountid = ? and entityid = ?"
										  );
				ps.setString(1,accountId);
				ps.setString(2,entityId);
				
				
				rs = ps.executeQuery();
				
				if(!rs.isBeforeFirst()){
					statuses.add(null);
				}
				
				while(rs.next()){
					status = new DeleteStatus();
					status.name = nvl(rs.getString("name"));
					status.year = nvl(rs.getString("year"));
					status.status = nvl(rs.getString("inactive"));
					statuses.add(status);
				}
				
			
			} catch (Exception e){
				throw e;
			}
		
		
		} catch (Exception e){
			throw e;
		} finally {
			try { conn.close(); } catch (Exception e){}
			try { ps.close(); } catch (Exception e){}
			try { rs.close();} catch (Exception e){}
		}
		
		DeleteStatus[] statusArr = statuses.toArray(new DeleteStatus[statuses.size()]);
		
		return statusArr;
	
	}

%>