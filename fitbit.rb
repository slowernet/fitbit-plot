require 'rubygems'
require 'sinatra'
require 'fitgem'	# http://rubydoc.info/gems/fitgem/0.5.1/frames
require 'sinatra/reloader' if development?

require 'config'

configure do
	set :root, File.dirname(__FILE__)
	set :inline_templates, true

	$client = Fitgem::Client.new({
		:consumer_key => CONFIG[:fitbit][:auth][:consumer_key], 
		:consumer_secret => CONFIG[:fitbit][:auth][:consumer_secret], 
		:token => CONFIG[:fitbit][:auth][:access_token],
		:secret => CONFIG[:fitbit][:auth][:access_secret], 
		:user_id => CONFIG[:fitbit][:user_id]
	})
end

get '/' do
	erb :index
end

get '/data.json' do
	content_type 'application/json'
	d = $client.data_by_time_range("#{params[:e]}", { :base_date => 'today', :period => '1y' })
	d = d[d.keys.first][1..-1]
	d = d.map { |d| [(Date.parse(d.values.first) - Date.new(1970,1,1)).to_i * 3600 * 24 * 1000, d.values.last.to_f ] }
	d.to_json
end

# client = Fitgem::Client.new({:consumer_key => CONFIG[:fitbit][:auth][:consumer_key], :consumer_secret => CONFIG[:fitbit][:auth][:consumer_secret]})
# request_token = client.request_token
# token = request_token.token
# secret = request_token.secret
# puts "Go to http://www.fitbit.com/oauth/authorize?oauth_token=#{token} and then enter the verifier code below and hit Enter"
# verifier = gets.chomp
# access_token = client.authorize(token, secret, { :oauth_verifier => verifier })
# puts "Verifier is: " + verifier + ", Token is:    "+access_token.token + ", Secret is:   "+ access_token.secret

__END__

@@ layout
<!doctype html> 
<html lang="en"> 
<head>
	<meta charset="utf-8">
	<title>fitbit</title>
	<style type="text/css" media="screen">
		html,body,div,span,applet,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,big,cite,code,del,dfn,em,img,ins,kbd,q,s,samp,small,strike,strong,sub,sup,tt,var,b,u,i,center,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,canvas,details,embed,figure,figcaption,footer,header,hgroup,menu,nav,output,ruby,section,summary,time,mark,audio,video{border:0;font-size:100%;font:inherit;vertical-align:baseline;margin:0;padding:0;}article,aside,details,figcaption,figure,footer,header,hgroup,menu,nav,section{display:block;}body{line-height:1;}ol,ul{list-style:none;}blockquote,q{quotes:none;}blockquote:before,blockquote:after,q:before,q:after{content:none;}table{border-collapse:collapse;border-spacing:0;}
		body { padding: 12px; font-size: 14px; }
		a { text-decoration: none; color: #88b; }
		.loading { background: transparent url(http://curbednetwork.com/images/spinner.gif) 50% 50% no-repeat; }
		.credit { position: absolute; bottom: 3px; right: 3px; color: #666; font-size: 12px; }
	</style>
	<link rel="apple-touch-icon" href="/apple-touch-icon.png">
	
	<script type="text/javascript" defer charset="utf-8">
		/*!
		  * $script.js Async loader & dependency manager
		  * https://github.com/ded/script.js
		  * (c) Dustin Diaz, Jacob Thornton 2011
		  * License: MIT
		  */
		!function(a,b){typeof define=="function"?define(b):typeof module!="undefined"?module.exports=b():this[a]=b()}("$script",function(){function s(a,b,c){for(c=0,j=a.length;c<j;++c)if(!b(a[c]))return m;return 1}function t(a,b){s(a,function(a){return!b(a)})}function u(a,b,c){function o(a){return a.call?a():f[a]}function p(){if(!--m){f[l]=1,j&&j();for(var a in h)s(a.split("|"),o)&&!t(h[a],o)&&(h[a]=[])}}a=a[n]?a:[a];var e=b&&b.call,j=e?b:c,l=e?a.join(""):b,m=a.length;return setTimeout(function(){t(a,function(a){if(k[a])return l&&(g[l]=1),k[a]==2&&p();k[a]=1,l&&(g[l]=1),v(!d.test(a)&&i?i+a+".js":a,p)})},0),u}function v(a,d){var e=b.createElement("script"),f=m;e.onload=e.onerror=e[r]=function(){if(e[p]&&!/^c|loade/.test(e[p])||f)return;e.onload=e[r]=null,f=1,k[a]=2,d()},e.async=1,e.src=a,c.insertBefore(e,c.firstChild)}var a=this,b=document,c=b.getElementsByTagName("head")[0],d=/^https?:\/\//,e=a.$script,f={},g={},h={},i,k={},l="string",m=!1,n="push",o="DOMContentLoaded",p="readyState",q="addEventListener",r="onreadystatechange";return!b[p]&&b[q]&&(b[q](o,function w(){b.removeEventListener(o,w,m),b[p]="complete"},m),b[p]="loading"),u.get=v,u.order=function(a,b,c){(function d(e){e=a.shift(),a.length?u(e,d):u(e,b,c)})()},u.path=function(a){i=a},u.ready=function(a,b,c){a=a[n]?a:[a];var d=[];return!t(a,function(a){f[a]||d[n](a)})&&s(a,function(a){return f[a]})?b():!function(a){h[a]=h[a]||[],h[a][n](b),c&&c(d)}(a.join("|")),u},u.noConflict=function(){return a.$script=e,this},u})
		
		$script.order([
			'http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js',
			'http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.3.1/underscore-min.js',
			'jquery.flot.min.js'
		], 'bundle');
		
		window.config = <%= CONFIG[:plot].to_json %>;
	</script>
</head>
<body>
	<select>
		<option value="/activities/log/steps" data-graph-zero-origin="true">Steps</option>
		<option value="/activities/log/distance">Miles</option>
		<option value="/activities/log/floors">Floors</option>
		<!-- <option value="/activities/log/calories">Calories</option> -->
		<!-- <option value="/body/weight" data-graph-zero-origin="false">Weight</option> -->
	</select>
	<div id="canvas"></div>
	<div class="credit">graphs by <a href="https://github.com/slowernet/fitbit-plot">fitbit-plot</a></div>
</body>

<script type="text/javascript" charset="utf-8">
	$script.ready('bundle', function() {
		var plot = null;
			
		$('select').change(function(ev) {
			$('#canvas').empty().addClass('loading');
			var $select = $(this);
			if ($select.val() == '') return;
			
			$.getJSON('/data.json', { 
				e: $(this).val().toLowerCase() 
			}, function(d) {
				var yorigin = $select.find(":selected").data('graph-zero-origin') ? 0 : null;
				plot = $.plot(
					$("#canvas"), [
						{ data: d },
						{ data: _.map(_.range(config["moving_average_days"]-1, d.length-1), function(i) { return [ d[i][0], (_.inject(d.slice(i-(config["moving_average_days"]-1), i+1), function(acc, j) { return acc + j[1]; }, 0) / config["moving_average_days"]) ]; }) }
					], {
						series: {
							lines: { show: true },
							points: { show: true }
						},
						colors: [ '#999', '#a00' ],
						xaxis: {
							mode: "time",
							minTickSize: [1, "day"]
						},
						yaxis: {
							ticks: 10,
							min: yorigin
						},
						grid: {
							hoverable: true
						}
					}
				);
				$('#canvas').removeClass('loading');
			});
		});

		var previousPoint = null;
		$("#canvas").bind("plothover", function (event, pos, item) {
			if (item) {
				if (previousPoint != item.dataIndex) {
					previousPoint = item.dataIndex;

					$("#tooltip").remove();
					var x = item.datapoint[0].toFixed(2),
					y = item.datapoint[1].toFixed(2);

					showTooltip(item.pageX, item.pageY, y);
				}
			} else {
				$("#tooltip").remove();
				previousPoint = null;            
			}
		});

		function showTooltip(x, y, contents) {
			$('<div id="tooltip">' + contents + '</div>').css({
				position: 'absolute',
				display: 'none',
				top: y + 5,
				left: x - 58,
				border: '1px solid #fdd',
				padding: '2px',
				'background-color': '#fee',
				opacity: 0.80
			}).appendTo("body").fadeIn(200);
		}

		$('#canvas').height($(document).height() - 50);

		$('select').val('/activities/log/steps').change();		
	});
</script>
</html>

@@ index