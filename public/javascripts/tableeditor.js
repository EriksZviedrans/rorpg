// TODO: enter key for new buttons
;(function($){
    $.fn.grid = function(options) {
    
        var curText = '';
        
	    $.fn.grid.defaults = {
            msgConfirmDelete: 'Are you sure you want to delete selected items?',
            msgNoSelectedItems: 'You have not selected any item',
	        rowColorOdd: '#eeeeef',
	        rowColorEven: '#ffffff',
	        rowColorOn: '#FFAC7F',
	        rowColorOff: '',
	        rowColorEdit: '#FF7F7F',
	    };
	    var options = jQuery.extend({}, $.fn.grid.defaults, options);

        _grid = this;
        var $this = null;
        
        /**
         * Delete selected rows
         *
         */
        function deleteRows(){
            var boxes = $this.find('input:checkbox.items:checked');
            if(!boxes.length){
                alert(options.msgNoSelectedItems); 
                return false;
            }
            if(!confirm(options.msgConfirmDelete)){
                return false;
            }
            for(var i=0; i<boxes.length; i++){
                $('#row_' + boxes[i].value).fadeTo(5000, 1).remove();
            }
            refreshZebra();
        }
        
        function addRow(){
            var tpl = $this.find('tr:last').clone();
            var newId = parseId(tpl.attr('id')) + 1;
            
            tpl.attr('id', 'row_' + newId);
            tpl.find(':checkbox').val(newId);
            
            bindDblClick(tpl.find('td.txt'));
            tpl.find('td.txt').find('span').html('');
            
            bindHovers(tpl);
            bindLeaveSelect(tpl.find('td.sel select'));
            $this.find('table').append(tpl);
            
            refreshZebra();
        }
        
        function parseId(mixedId){
            var arrId = mixedId.split('_');
            return parseInt(arrId[1], 10);
        }
        
        function saveAll(){
            // TODO: save all
        }
        
        /**
         * Makes cell editable
         *
         */
        function editTxt(td){
            var span = td.find('span');
            curText = span.html();
            
            td.css('width', td.css('width'));
            td.css('height', td.css('height'));
            
            var parentRow = td.parent(); 
            parentRow.css('background-color', options.rowColorOff).addClass('editMode');
            
            span.hide();
            
            
            if(td.hasClass('txt')){
	            var inp = td.find('input');
	            if(!inp.length){
	                inp = $('<input type="text" value="' + curText + '" class="gridEdit" />');
	                td.append(inp);
	                inp.keypress(function(e){
	                    bindLeaveEdit(inp, e);
	                }).blur(function(e){ bindLeaveEdit(inp, e); });
	            } else {
	                inp.val(curText);
	                inp.show();
	            }
            } else if (td.hasClass('sel')) {
                var inp = td.find('select');
                var val = td.find('input:hidden').val();
                
                inp.find('option[value="' + val + '"]').attr('selected', 'selected');
                inp.show();
                
                /*
                if(!inp.length){
                    inp = $('<input type="text" value="' + curText + '" class="gridEdit" />');
                    td.append(inp);
                    inp.keypress(function(e){
                        bindLeaveEdit(inp, e);
                    }).blur(function(e){ bindLeaveEdit(inp, e); });
                } else {
                    inp.val(curText);
                    inp.show();
                }
                */
            }
            inp.focus();
        }
        
        /**
         * Leave cell after edit
         *
         */
	    function bindLeaveEdit(edit, ev){
	       ev.cancelBubble = true;
	       var span = edit.prev('span');
	       
	       if(ev == undefined){
	           edit.hide();
	           span.show();
	           edit.parent().parent().removeClass('editMode');
	       }
           var keyCode = ev.keyCode ? ev.keyCode : ev.which;
           if(keyCode == 13){
               if(edit.parent().hasClass('txt')){
                   span.html(edit.val()+'');
               } else if (edit.parent().hasClass('sel')){
                   span.html(edit.find(':selected').html()+'');
               }
               exitEditMode(edit, span);
           } else if(keyCode == 27 || keyCode == undefined){
               exitEditMode(edit, span);
           } else if(keyCode == 9){
               span.html(edit.val()+'');
               exitEditMode(edit, span);
               
               var nextTd = edit.parent().next('td');
               nextTd.trigger('dblclick');
               
           }
           refreshZebra();
	    }
	    
	    function exitEditMode(edit, span){
	       edit.hide();
           span.show();
           edit.parent().parent().removeClass('editMode');
	    }
	    
	    function bindLeaveSelect(select){
	        select.change(function(){
	            var _sel = $(this);
	            var span = _sel.prev('span');
	            span.html(_sel.find(':selected').html()+'');
	            _sel.next('input:hidden').val(_sel.find(':selected').val());
	            
	            span.show();
	            _sel.hide();
	            _sel.parent().parent().removeClass('editMode');
	        });
	        refreshZebra();
	    }
	    
	    /**
         * Refresh rows color (odd)
         *
         */
	    function refreshZebra(){
	       $this.find('tr:odd').css('background-color', options.rowColorOdd);
	       $this.find('tr:even').css('background-color', options.rowColorEven);
	    }

        function bindHovers(jqRowObj){
            jqRowObj.mouseover(function(){
                                var row = $(this);
                                options.rowColorOff = row.css('background-color');
                                if(!row.hasClass('editMode')){
                                    row.css('background-color', options.rowColorOn);
                                } else {
                                    //row.css('background-color', options.rowColorEdit);
                                }
                            })
                            .mouseout(function(){
                                if(!$(this).hasClass('editMode')){
                                    $(this).css('background-color', options.rowColorOff);
                                }
                            })
            ;
        }
        
        function bindDblClick(jqCell){
            jqCell.dblclick(function(){
                if(!$(this).parent().hasClass('editMode')){
                    editTxt($(this));
                }
            });
        }
        
        
        return this.each(function() {
            $this = $(this);
            
            $this.find('td.txt').wrapInner('<span></span>');
		    bindHovers($this.find('tr'));
		    
            refreshZebra();
            
            // Select all
            $this.find('input:checkbox.selAll').click(function(){
                if(this.checked){
                    $this.find('input:checkbox.items').attr('checked', 'checked');
                } else {
                    $this.find('input:checkbox.items').removeAttr('checked');
                }
            });
            
            $this.find('.btnDel').click(function(){
                deleteRows();
            });
            
            $this.find('.btnAdd').click(function(){
                addRow();
            });
            
            $this.find('.btnSend').click(function(){
                saveAll();
            });
            
            bindDblClick($this.find('td.txt, td.sel'));
            
            bindLeaveSelect($this.find('td.sel select'));
            
            
            
        });
        
        
    };
    
})(jQuery);
