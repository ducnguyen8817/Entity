<%!
public String toJson(Object obj) {
        boolean isClassArray = false;
        StringBuffer arrBuffer = new StringBuffer();
        StringBuffer buffer = new StringBuffer();
        Object arrayElement = null;
        int    arrayLength  = 0;

        if ( obj == null ) return ("");

        // If this is an array we need to handle each element individually
        if ( obj.getClass().isArray() ) {
            arrayLength = java.lang.reflect.Array.getLength(obj);
            buffer.append("[ ");
            if ( arrayLength > 0 ) {
                arrayElement = java.lang.reflect.Array.get(obj, 0);
                buffer.append(toJson(arrayElement));
                for ( int j=1; j < arrayLength; j++ ) {
                    buffer.append(",\n");
                    arrayElement = java.lang.reflect.Array.get(obj, j);
                    buffer.append(toJson(arrayElement));
                }
            }
            buffer.append(" ]");
            return buffer.toString();
        }


        Field [] fields = obj.getClass().getDeclaredFields();
        for ( int i=0; i < fields.length; i++ ) {
            if ( fields[i].getModifiers() != Modifier.PUBLIC ) continue;

            Class  classType  = fields[i].getType();

            String fieldName  = fields[i].getName();
            String fieldValue = "";

            try {
                if ( fields[i].get(obj) != null ) {
                    if ( fields[i].getType().equals(java.lang.Integer.TYPE) ) {
                        fieldValue = ""+fields[i].getInt(obj);
                    } else if ( fields[i].getType().equals(java.lang.Boolean.TYPE) ) {
                        fieldValue = ""+fields[i].getBoolean(obj);
                    } else if ( fields[i].getType().equals(java.lang.Long.TYPE) ) {
                        fieldValue = ""+fields[i].getLong(obj);
                    } else if ( fields[i].getType().equals(java.lang.Double.TYPE) ) {
                        fieldValue = ""+fields[i].getDouble(obj);
                    } else if ( fields[i].getType().getName().equals("java.lang.String") ) {
                        fieldValue = "\"" + nvl((String)fields[i].get(obj)).replaceAll("\\\"","\\\\\"") + "\"";
                    } else {
                        if ( fields[i].get(obj).getClass().isArray() ) {
                            arrBuffer.setLength(0);
                            isClassArray = fields[i].getType().toString().startsWith("class [L")
                                    && ! classType.getName().equals("[Ljava.lang.String;");
                            arrayLength = java.lang.reflect.Array.getLength(fields[i].get(obj));
                            for (int j = 0; j < arrayLength; j++) {
                                arrayElement = java.lang.reflect.Array.get(fields[i].get(obj), j);
                                arrBuffer.append("\n { \"" + fieldName.replaceAll("s$","") + "\": ");
                                arrBuffer.append((isClassArray ? "\n" + toJson(arrayElement) : "\"" + arrayElement + "\""));
                                arrBuffer.append(" } ");
                                if ( j < arrayLength-1 ) arrBuffer.append(",");
                                arrBuffer.append(" ");
                            }
                            fieldValue = "[ " + arrBuffer.toString() + " ]\n";
                            arrBuffer.setLength(0);
                        } else {
                            // We'll assume this is a simple Class
                            if ( fields[i].get(obj) != this ) fieldValue = "\n" + toJson(fields[i].get(obj));
                        }
                    }
                }
            } catch (Exception e) {
                fieldValue = e.toString();
            }

            if ( buffer.length() > 0 ) buffer.append(", ");
            buffer.append( "\"" + fieldName + "\": " + (fieldValue.length() == 0 ? "\"\"" : fieldValue));
        }

        return "{ " + buffer.toString() + " }";
}
	
	
		// //////////////////////////////////////////////////////////////////////
		// Utility/Convenience Methods
		// //////////////////////////////////////////////////////////////////////
		
		public boolean notDefined(String val) { return (val==null || val.length()==0);}
		public String nvl(String val){ return (val == null ? "":val);}
		public String nvl(String val, String def){ return(notDefined(val) ? def:val);}
		public Double nvl(String val, double def){ try{ return Double.parseDouble(val);} catch (Exception e){return def;}}
		public Long nvl(String val, long def) { try{ return Long.parseLong(val);} catch (Exception e) {return def;}}
	
%>