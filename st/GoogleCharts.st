Smalltalk current createPackage: 'GoogleCharts' properties: #{}!
Object subclass: #ChartApp
	instanceVariableNames: 'visualLoader idSeries'
	package: 'GoogleCharts'!
!ChartApp commentStamp!
A chart app is an example App which loads the google JSAPI and visualization API.!

!ChartApp methodsFor: 'init'!

begin
	"Start the executiong of the ChartApp"
	^self
!

getUniqueId
	^'uniqie', (idSeries next printString).
!

initialize
	"Load my external JS"
    idSeries := SerialNumber new.
    GoogleLoader load:[self visualLoader loadPackages:(self class neededVisualizationPackages ) onLoadCallback:[self begin]]
!

register: aChartGadget

	^aChartGadget
!

register: aChartGadget requires: anArray onLoaded: aBlock
	"Register aGadget with a callback when loading is complete."
	self loader requires:anArray onLoaded: aBlock
!

visualLoader
	"Return the loader"
    ^visualLoader ifNil:[visualLoader := GoogleVisualization new]
! !

!ChartApp class methodsFor: 'not yet classified'!

loadVisualization: callback
	"Use google.load() to load visualization and load the needed packages"
    |packages|
    packages := self neededVisualizationPackages.
    <google.load("visualization","1",{"callback" : callback , "packages":packages});>
!

neededVisualizationPackages
"This is a hook for subclasses to define which visualization packages to load."
	^{}
! !

Object subclass: #ChartButton
	instanceVariableNames: 'element clickBlock'
	package: 'GoogleCharts'!

!ChartButton methodsFor: 'not yet classified'!

activate
	|button|
	button := self element asJQuery.
    button click:[self clickBlock value]
!

clickBlock
	^clickBlock
!

clickBlock: aBlock
	clickBlock := aBlock
!

element
	^element
!

element: aSymbol
	element := aSymbol
! !

!ChartButton class methodsFor: 'not yet classified'!

element: elementSymbol clickBlock: clickBlock
	^self new element: elementSymbol; clickBlock: clickBlock; activate;yourself
!

popUpChart: chart atDom: element
	"Make the chart popup on click of an element"
    ^self element: element clickBlock:[chart drawChartData: chart makeData options: chart makeOptions]
! !

Object subclass: #GoogleChart
	instanceVariableNames: 'chart chartId chartType'
	package: 'GoogleCharts'!

!GoogleChart methodsFor: 'abstraction'!

makeData
	"abstraction - return the data for a google chart"
  	 ^self subclassresponsibility
!

makeOptions
	"Abstract method - return options for a Google Chart"
   ^	 self subclassresponsibility
! !

!GoogleChart methodsFor: 'accessor'!

chart
	^chart ifNil:[chart := self makeChart:self chartId]
!

chartId
	^chartId
!

chartId: aString
	chartId := aString
!

chartType
	^ chartType
!

chartType: aString
	chartType := aString
! !

!GoogleChart methodsFor: 'chart'!

drawChartData: data options: options
	self class drawChart:self chart data: data options:options
!

makeChart: id
"build a chart at specific element id in the DOM and return"

    ^self class makeChartType:(self chartType) on: id
! !

!GoogleChart methodsFor: 'init'!

initialize
	^self
! !

!GoogleChart class methodsFor: 'DOM'!

getElementById: id
	"Find element by the id in the DOM"
	^ <document.getElementById(id)>
! !

!GoogleChart class methodsFor: 'data table'!

arrayToDataTable: array

	^ <google.visualization.arrayToDataTable(array)>
! !

!GoogleChart class methodsFor: 'instance creation'!

type: type element: e
"build a chart at specific element  in the DOM"

    ^ <new google.visualization[type](e)>
! !

!GoogleChart class methodsFor: 'not yet classified'!

chartId: aString
	^self new chartId:aString;yourself
!

drawChart: chart data: data options: options

     <chart.draw(data,options)>
!

makeChartType: type on: id
"build a chart at specific element id in the DOM and return"
	^self type: type element: (self  getElementById:id)
! !

!GoogleChart class methodsFor: 'planning and allocate'!

allocateResourcesProvider: aProvider type: aType
	^self subclassresponsiblity
!

planResourcesProvider: aProvider type: aType
	^self subclassresponsiblity
! !

GoogleChart subclass: #GaugeChart
	instanceVariableNames: ''
	package: 'GoogleCharts'!

!GaugeChart methodsFor: 'not yet classified'!

initialize
	" Create a Guage with the chartId that identifies the chart graphic placement and the chartType to be created at that id."
    super initialize.
    self chartType:'Gauge'.
	^self
! !

GoogleChart subclass: #GeoChart
	instanceVariableNames: ''
	package: 'GoogleCharts'!

!GeoChart methodsFor: 'not yet classified'!

initialize
	" Create a Geo Chart"
    super initialize.
    self chartType:'GeoChart'.
	^self
! !

GoogleChart subclass: #PieChart
	instanceVariableNames: ''
	package: 'GoogleCharts'!

!PieChart methodsFor: 'not yet classified'!

initialize
	super initialize.
    self chartType:'PieChart'.
	^self
! !

GoogleChart subclass: #ScatterChart
	instanceVariableNames: ''
	package: 'GoogleCharts'!

!ScatterChart methodsFor: 'not yet classified'!

initialize
	super initialize.
    self chartType:'ScatterChart'.
	^self
! !

Object subclass: #LoadRequest
	instanceVariableNames: 'packages block'
	package: 'GoogleCharts'!

!LoadRequest methodsFor: 'accessor'!

block
	"Return the block"
    ^block
!

block: aBlock
	"Set the block"
    block := aBlock
!

isSatisfied
	^self packages isEmpty
!

packages
   "return the packages"
    ^packages ifNil:[packages := Set new]
!

packages: aCollection
   "Set the packages"
    packages := aCollection asSet
!

removeLoaded: aSet
	self packages:(self packages reject:[:item|aSet includes:item])
! !

Object subclass: #UniqueIdProvider
	instanceVariableNames: 'prefix serial'
	package: 'GoogleCharts'!

!UniqueIdProvider methodsFor: 'not yet classified'!

initialize
	"Create a SerialNumber and Prefix"

	serial := SerialNumber new .
	prefix := 'idxyz'.
!

next
	^prefix ,serial next printString
! !

Error subclass: #UnknownRequestError
	instanceVariableNames: ''
	package: 'GoogleCharts'!

