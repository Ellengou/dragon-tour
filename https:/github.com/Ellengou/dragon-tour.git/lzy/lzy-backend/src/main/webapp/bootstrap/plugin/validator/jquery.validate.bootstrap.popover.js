// Generated by CoffeeScript 1.6.3
(function() {
    var $;

    $ = jQuery;

    $.fn.extend({
        validate_popover: function(options) {
            var settings;
            settings = $.extend(true, {}, $.validator.popover_defaults, options);
            if (settings.get_offset_element) {
                $.validator.get_offset_element = settings.get_offset_element;
            }
            return this.validate(settings);
        }
    });

    $.extend($.validator, {
        popover_defaults: {
            onsubmit: false,
            popoverPosition: 'top',
            popoverContainer: 'body',
            hideForInvisible: true,
            success: function(error, element) {
                return $.validator.hide_validate_popover(element);
            },
            errorPlacement: function(error, element) {
                var message;
                message = error.html();
                this.beforeShowError.call(element.get(0), message);
                return $.validator.show_error(message, element);
            },
            beforeShowError: function(message) {}
        },
        popover_elements_cached: [],
        hide_validate_popover: function(element) {
            var ele, _i, _len, _results;
            if (element.length > 1) {
                _results = [];
                for (_i = 0, _len = element.length; _i < _len; _i++) {
                    ele = element[_i];
                    _results.push($.validator.get_validate_popover(ele));
                }
                return _results;
            } else {
                return $.validator.get_validate_popover(element);
            }
        },
        show_error: function(message, element) {
            var $v_popover;
            $v_popover = $.validator.get_validate_popover(element);
            $('.popover-content', $v_popover).html(message);
            $.validator.reset_position($v_popover, element);
            if ((message != null) && message !== '') {
                return $v_popover.show();
            }
        },
        get_offset_element: function(element) {
            return $(element);
        },
        reset_position: function(popover, element) {
            var left, left_adjust, offset, offset_adjust, position, top, top_adjust, _ref;
            offset = $.validator.get_offset_element(element).offset();
            offset_adjust = $(element).data('popover-offset') || "0,0";
            _ref = offset_adjust.split(','), top_adjust = _ref[0], left_adjust = _ref[1];
            position = $.validator.get_position(element);
            if (position === 'top') {
                top = offset.top - 11 - 26 + parseInt(top_adjust);
                left = offset.left + parseInt(left_adjust);
            } else {
                top = offset.top - 3 + parseInt(top_adjust);
                left = offset.left + $(element).width() + 20 + parseInt(left_adjust);
            }
            return popover.css({
                top: top,
                left: left
            });
        },
        get_position: function(element) {
            return $(element).data('popover-position') || $.validator.validator_settings(element).popoverPosition;
        },
        reposition: function(elements) {
            var ele, element, popover, reposition_elements, _i, _len, _results;
            if (elements != null) {
                reposition_elements = elements;
            } else {
                reposition_elements = $.validator.popover_elements_cached;
            }
            _results = [];
            for (_i = 0, _len = reposition_elements.length; _i < _len; _i++) {
                element = reposition_elements[_i];
                ele = $(element);
                popover = ele.data('validate-popover');
                if ((popover != null) && popover.is(":visible")) {
                    if ($.validator.hide_popover_for_invisible(element) && !ele.is(":visible")) {
                        _results.push(popover.hide());
                    } else {
                        _results.push($.validator.reset_position(popover, element));
                    }
                } else {
                    _results.push(void 0);
                }
            }
            return _results;
        },
        get_validate_popover: function(element) {
            var $container, v_popover;
            v_popover = $(element).data('validate-popover');
            if (v_popover == null) {
                $container = $($.validator.validator_settings(element).popoverContainer);
                v_popover = $("<div class='popover " + ($.validator.get_position(element)) + " error-popover' id='validate-popover'><div class='arrow'></div><div class='popover-content'></div></div>").appendTo($container);
                v_popover.click(function() {
                    return $(this).hide();
                });
                $(element).data('validate-popover', v_popover);
                $.validator.popover_elements_cached.push(element);
            }
            return v_popover.hide();
        },
        hide_popover_for_invisible: function(element) {
            var element_setting;
            element_setting = $(element).data('popover-hide-for-invisible');
            if (element_setting != null) {
                return element_setting;
            } else {
                return $.validator.validator_settings(element).hideForInvisible;
            }
        },
        validator_settings: function(element) {
            return $.data($(element)[0].form, "validator").settings;
        }
    });

}).call(this);