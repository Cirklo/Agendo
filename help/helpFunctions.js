	// Javascript to resize the an element to fit screen without a certain margin
	function setElementSize(elementName,marginW,marginH,minWidth,minHeight){
			var wWidth = window.innerWidth;
			var wHeight = window.innerHeight;
			var setWidth;
			var setHeight;
			
			if(wWidth > minWidth)
				setWidth = wWidth - marginW;
			else
				setWidth = minWidth - marginW;

			if(wHeight > minHeight)
				setHeight = wHeight - marginH;
			else
				setHeight = minHeight - marginH;

			document.getElementById(elementName).style.width = setWidth;
			document.getElementById(elementName).style.height = setHeight;
	}
