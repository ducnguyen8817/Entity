<%@ page import="java.util.*,java.lang.*,java.io.*,java.nio.file.*,java.nio.channels.*"
%>
<%
	String year = request.getParameter("year");
    String dir  = "C:\\Users\\Duc.Nguyen\\Desktop\\glassfish-4.0\\glassfish4\\glassfish\\domains\\domain1\\applications\\application\\worksheets\\";
	String dir2 = "C:\\Users\\Duc.Nguyen\\Desktop\\glassfish-4.0\\glassfish4\\glassfish\\domains\\domain1\\applications\\application\\";
	String dir3 = "C:\\Users\\Duc.Nguyen\\Desktop\\glassfish-4.0\\glassfish4\\glassfish\\domains\\domain1\\applications\\Entity\\WEB-INF\\classes\\configuration\\";
	String dir4 = "C:\\Users\\Duc.Nguyen\\Desktop\\glassfish-4.0\\glassfish4\\glassfish\\domains\\domain1\\applications\\application\\WEB-INF\\classes\\configuration\\";
	String dir5 = "C:\\Users\\Duc.Nguyen\\Desktop\\glassfish-4.0\\glassfish4\\glassfish\\domains\\domain1\\applications\\application\\worksheets\\";
	
	Properties configuration = load(this,"tnt");
	String    system_year           = configuration.getProperty("system_year");
	
		
	String from = system_year;
	String to   = year;
	File source = new File(dir+from);
	File dest   = new File(dir+to);
	File worksheet_year = new File(dir5+to);
	String mainPath   =  dir2+"main.jsp";
	String loginPath  =  dir2+"login.jsp";
	String configPath =  dir2+"configuration.inc";
	String config_Entity_Path = dir3+"tnt.cfg";
	String config_Application_Path = dir4+"tnt.cfg";
	
	
	
	try {
		
	
		
		replaceYear(from, to, mainPath);
		replaceYear(from, to, loginPath);
		replaceYear(from, to, configPath);
		replaceYear(from, to, config_Entity_Path);
		replaceYear(from, to, config_Application_Path);
		
		if(!dest.exists()){
			copyFolder(source, dest, from, to);
			replaceYears(worksheet_year,from,to);
			replaceYears(worksheet_year,Integer.toString(Integer.parseInt(from)-1), Integer.toString(Integer.parseInt(to)-1));
		}	
		
		out.println("Successfully applied the selected year");
	} catch (Exception e){
		out.println(e.toString());
	}
%>
<%!
	
	Properties load(Object obj, String name) throws Exception {
		InputStream in  = null;
		Properties configuration = new Properties();

		try { 
			in = obj.getClass().getResource("/configuration/" + name + ".cfg").openStream();
			configuration.load(in);
			if ( configuration.isEmpty() ) throw new IOException("ConfigurationLookup (" + name + ") failed to load.");
		} catch (java.lang.NullPointerException npe) { // Thrown when file does not exist
			throw new IOException("Configuration (" + name + ") does not exist.");
		} finally {
			if ( in != null ) { try { in.close(); } catch (Exception e) {} in = null; }
		}

		return configuration;
	}

	public void copyFile(File source, File dest) throws IOException{
		Files.copy(source.toPath(), dest.toPath());
	}
	
	public void copyFileChannel(File source, File dest) throws IOException{
		FileChannel sourceChannel = new FileInputStream(source).getChannel();
        FileChannel destChannel = new FileOutputStream(dest).getChannel();

        destChannel.transferFrom(sourceChannel,0,sourceChannel.size());
	}
	
	 public  void copyFolder(File source, File dest, String from, String to) throws IOException{

        if(!dest.exists()){
            dest.mkdir();
            File [] contents = source.listFiles();
            if(contents!= null){
                for(File f : contents){
                    File newFile = new File(dest.getAbsolutePath()+File.separator+f.getName());
                    if(f.isDirectory()){
                        copyFolder(f,newFile, from, to);
                    } else {
						copyFile(f,newFile);

                    }
                }
            }

        } 

    }
	
	public void replaceYear(String find, String replace, String path) throws IOException{
		Path filePath = Paths.get(path);
        String fileContent = new String(Files.readAllBytes(filePath));
        fileContent = fileContent.replaceAll(find, replace);
        Files.write(filePath,fileContent.getBytes());
	}
	
	public  void replaceYears(File source, String find, String replace) throws IOException {
        File [] content = source.listFiles();

        for(File f: content){
            File newFile = new File(source.getAbsolutePath()+File.separator+f.getName());

            if(f.isDirectory() && !f.getName().equals("images")) {
               replaceYears(newFile, find, replace);
            } else if ( !f.getName().equals("images") ) {

                String path = newFile.getAbsolutePath().replace("\\","\\\\");
                System.out.println(path);
                replaceYear(find,replace, path);

            }
        }
    }


%>