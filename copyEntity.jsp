<%@ page import="java.util.*, java.sql.*,tnt3.*, java.lang.*, act.util.*, java.lang.reflect.*"
%><%@ include file="utility.jsp"
%><%
	String accountId_from = nvl(request.getParameter("account_from"));
	String entityId_from = nvl(request.getParameter("entity_from"));
	String year_from = nvl(request.getParameter("year_from"));
	String accountId_to = nvl(request.getParameter("account_to"));
	String entityId_to = nvl(request.getParameter("entity_to"));
	String year_to = nvl(request.getParameter("year_to"));;
	
	try {
		out.println(copyEntity(accountId_from, entityId_from, year_from, accountId_to, entityId_to, year_to));
		
	} catch (Exception e){
		out.println (e.toString());
	}
%><%!

	
	
	public String copyEntity(String accountId_from, String entityId_from, String year_from, 
							String accountId_to, String entityId_to, String year_to) throws Exception {
	
		Connection 	 		conn		= null;
		PreparedStatement	ps 			= null;
		
		String dataSource	= "jdbc/development";
		String status		= "";
		
		try {
			conn = DBConnection.openConnection(dataSource);
			try {
				ps = conn.prepareStatement("update tnt_entity"
										  +" Set( name, type, precision, salestax,"
										  +"	aggressive_rounding, distinct_rates,"
										  +"	fmfc, srb, inactive,etr_option ) = "
										  +"	(select name, type, precision, salestax,"
										  +" 		aggressive_rounding, distinct_rates,"
										  +"		fmfc, srb, inactive, etr_option"
										  +"	from tnt_entity"
										  +"	where accountid = ?"
										  +" 		and entityid = ?"
										  +"		 and year = ?)"
										  +"where accountid= ? and entityid = ?"
										  +"	and year= ?"
										   );
				ps.setString(1,accountId_from);
				ps.setString(2,entityId_from);
				ps.setString(3,year_from);
				ps.setString(4,accountId_to);
				ps.setString(5,entityId_to);
				ps.setString(6,year_to);
				
				ps.executeUpdate();
				status = "Sucessfully copied the entity data";
			} catch (Exception e) {
				throw e;
			}
		
		} catch (Exception e) {
			throw e;
		} finally {
			try { conn.close(); } catch (Exception e){}
			try { ps.close(); } catch (Exception e){}
		}
		
		return status;
	
	}
	
	
	
	
%>