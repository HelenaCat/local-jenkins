class Dashing.JenkinsBuild extends Dashing.Widget
 
  @accessor 'value', Dashing.AnimatedValue
  @accessor 'bgColor', ->
    if @get('currentResult') == "SUCCESS"
      "#10942B"
    else if @get('currentResult') == "FAILURE"
      "#E32424"
    else if @get('currentResult') == "PREBUILD"
      "#ff9618"
    else if @get('currentResult') == "UNSTABLE"
      "#E3B912"
    else
      "#999"
  @accessor 'weather', ->
    if @get('icon') == "health-00to19.png"
       "https://svn.jenkins-ci.org/tags/hudson-1_162/hudson/main/war/resources/images/32x32/health-00to19.gif"
    else if @get('icon') == "health-20to39.png"
       "https://svn.jenkins-ci.org/tags/hudson-1_162/hudson/main/war/resources/images/32x32/health-20to39.gif"
    else if @get('icon') == "health-40to59.png" 
       "https://svn.jenkins-ci.org/tags/hudson-1_162/hudson/main/war/resources/images/32x32/health-40to59.gif"
    else if @get('icon') == "health-60to79.png"
       "https://svn.jenkins-ci.org/tags/hudson-1_162/hudson/main/war/resources/images/32x32/health-60to79.gif"
    else if @get('icon') == "health-80plus.png"
       "https://svn.jenkins-ci.org/tags/hudson-1_162/hudson/main/war/resources/images/32x32/health-80plus.gif"
  @accessor 'stability', ->
    if @get('building_info') == true
        "Building..."
    else if @get('health') == "Build stability: No recent builds failed."
        "No recent builds failed."
    else if @get('health') == "Build stability: All recent builds failed."
        "All recent builds failed."
    else if @get('currentResult') == "SUCCESS"
        @get('health').split(" ")[2] + "/" + @get('health').split(" ")[7] + " builds failed."
    else if @get('currentResult') == "UNSTABLE"
        @get('health').split(" ")[2] + "/" + @get('health').split(" ")[10] + " tests failed."
    else if @get('currentResult') == "FAILURE"
        @get('health').split(" ")[2] + "/" + @get('health').split(" ")[7] + " builds failed."

 
  constructor: ->
    super
    @observe 'value', (value) ->
      $(@node).find(".jenkins-build").val(value).trigger('change')
 
  ready: ->
      meter = $(@node).find(".jenkins-build")
      $(@node).fadeOut().css('background-color', @get('bgColor')).fadeIn()
      meter.attr("data-bgcolor", meter.css("background-color"))
      meter.attr("data-fgcolor", meter.css("color"))
      meter.knob()
       
  onData: (data) ->
    icon = $(@node).find(".icon")
    description = $(@node).find(".stability")
    if data.currentResult isnt data.lastResult
      $(@node).fadeOut().css('background-color', @get('bgColor')).fadeIn()
     icon.html($('<img src=\"' + @get('weather')  + '\" />'))
     description.html(@get('stability'))
      
  Batman.Filters.dateFormat = (date) ->
    moment(date).format("DD-MM-YYYY HH:mm:ss")
 

         


