package app 
{
	import mx.core.FlexGlobals;
	import mx.utils.URLUtil;
	
	public class URLS
	{	
		public function URLS() 
		{
			
		}
	
		public static function getOwnRawURL( ) : String
		{
			return FlexGlobals.topLevelApplication.url;
		}
		
		// ログアウト時に用いるURL
		public static function getLogoutURL( ) : String
		{
			var url : String = URLS.getOwnRawURL( );
			url = url.replace( /loginRoom=\d+\&?/, '' );
			url = url.replace( /\?$/, '' );
			url = url.replace( /\&$/, '' );
			return url;
		}
				
		// url : http://www.dodontof.com/DodontoF/DodontoF.swf
        // hostUrl : www.dodontof.com
        public static function isOwnHostURL(url:String):Boolean {
            var httpExp:RegExp = /^http/;
            var httpExpResult : Object = httpExp.exec( url );
            if ( httpExpResult == null )
			{
                return true;
            }
            
            var targetServerName:String = URLUtil.getServerName(url);
            
            var ownUrl:String = getOwnRawURL();
            var ownServerName:String = URLUtil.getServerName(ownUrl);
            
            var result:Boolean = (ownServerName == targetServerName);
            
            return result;
        }
        
        // http://www.dodontof.com/DodontoF/
        public static function getOwnBaseURL( ) : String
		{
            var url:String = getOwnRawURL();
            // Log.logging("getOwnUrlBase url", url);
            
            var regExp:RegExp = /(.+\/)/i;
            var regResult:Object = regExp.exec(url);
            
            if ( regResult == null )
			{
                // Log.loggingTuning("getOwnUrlBase CanNotGetOwnUrl");
                return "CanNotGetOwnBaseUrl";
            }
            
            var ownBaseUrl:String = regResult[1];
            // Log.loggingTuning("getOwnUrlBase ownUrl", ownBaseUrl);
            return ownBaseUrl;
        }
	}

}