(function() {
  var Assert, Document, OD, Page, Test;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  OD = ORBEON.util.Dom;
  Document = ORBEON.xforms.Document;
  Assert = YAHOO.util.Assert;
  Page = ORBEON.xforms.Page;
  Test = ORBEON.util.Test;
  YAHOO.tool.TestRunner.add(new YAHOO.tool.TestCase({
    name: "HTML Area",
    assertHTML: function(htmlExpectedOut) {
      var htmlActualOut, s, _ref;
      htmlActualOut = Document.getValue("xhtml-textarea");
      _ref = (function() {
        var _i, _len, _ref, _results;
        _ref = [htmlExpectedOut, htmlActualOut];
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          s = _ref[_i];
          _results.push(YAHOO.lang.trim(s).replace(new RegExp("  +", "g"), " "));
        }
        return _results;
      })(), htmlExpectedOut = _ref[0], htmlActualOut = _ref[1];
      return Assert.areEqual(htmlExpectedOut, htmlActualOut);
    },
    settingValue: function(htmlIn, htmlOut) {
      var newlineToSpace;
      newlineToSpace = function(s) {
        return s.replace(new RegExp("\n", "g"), " ");
      };
      htmlIn = newlineToSpace(htmlIn);
      htmlOut = newlineToSpace(htmlOut);
      window.setTimeout(__bind(function() {
        var rte;
        rte = Page.getControl(OD.get("xhtml-editor-1"));
        return rte.onRendered(__bind(function() {
          return this.resume(__bind(function() {
            return ORBEON.util.Test.executeCausingAjaxRequest(this, __bind(function() {
              return ORBEON.xforms.Document.setValue("xhtml-editor-1", htmlIn);
            }, this), __bind(function() {
              return this.assertHTML(htmlOut);
            }, this));
          }, this));
        }, this));
      }, this), ORBEON.util.Properties.internalShortDelay.get());
      return this.wait();
    },
    testSetup: function() {
      var container, i, rte, rte1, rte2, rteInitialized, _ref;
      rteInitialized = 0;
      _ref = (function() {
        var _i, _len, _ref, _results;
        _ref = [1, 2];
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          i = _ref[_i];
          container = OD.get("xhtml-editor-" + i);
          rte = Page.getControl(container);
          _results.push(rte.onRendered(__bind(function() {
            rteInitialized++;
            if (rteInitialized === 2) {
              return this.resume();
            }
          }, this)));
        }
        return _results;
      }).call(this), rte1 = _ref[0], rte2 = _ref[1];
      return this.wait();
    },
    testSimpleHTML: function() {
      var simpleHTML;
      simpleHTML = "Some different <b>content</b>.";
      return this.settingValue(simpleHTML, simpleHTML);
    },
    testJSInjection: function() {
      return this.settingValue("<div>Text to keep<script>doSomethingBad()</script></div>", "<div>Text to keep</div>");
    },
    testWordHTML: function() {
      return this.settingValue("            <p class=MsoNormal align=center            style='margin-bottom:0in;margin-bottom:.0001pt;text-align:center;line-height:normal'><b            style='mso-bidi-font-weight:normal'><u><span            style='font-size:14.0pt;mso-bidi-font-size:11.0pt;mso-fareast-font-family:&quot;Times New            Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;color:#0070C0'>Project            Description<o:p></o:p></span></u></b></p>            ", "            <p align=\"center\" class=\"MsoNormal\" style=\"margin-bottom:0in;margin-bottom:.0001pt;text-align:center;line-height:normal\"><b            style=\"mso-bidi-font-weight:normal\"><u><span            style=\"font-size:14.0pt;mso-bidi-font-size:11.0pt;mso-fareast-font-family:&quot;Times New            Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;color:#0070C0\">Project            Description</span></u></b></p>            ");
    },
    testFocus: function() {
      var container, i, rte, rte1, rte2, sampleHtml, _ref;
      _ref = (function() {
        var _i, _len, _ref, _results;
        _ref = [1, 2];
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          i = _ref[_i];
          container = OD.get("xhtml-editor-" + i);
          rte = Page.getControl(container);
          _results.push(rte.yuiRTE);
        }
        return _results;
      })(), rte1 = _ref[0], rte2 = _ref[1];
      sampleHtml = "Hello, World!";
      return ORBEON.util.Test.executeSequenceCausingAjaxRequest(this, [
        [
          function() {
            rte1.focus();
            return Document.setValue("xhtml-editor-1", "");
          }
        ], [
          function() {
            rte1.execCommand("inserthtml", sampleHtml);
            return rte2.focus();
          }, function() {
            var out;
            out = Document.getValue("xhtml-textarea");
            return Assert.isTrue((out.indexOf(sampleHtml)) !== -1);
          }
        ]
      ]);
    },
    testAddIterationAndSetValue: function() {
      return ORBEON.util.Test.executeSequenceCausingAjaxRequest(this, [
        [
          function() {
            return Test.click("add-iteration");
          }, function() {
            var container, rte;
            container = OD.get("rte-in-iteration" + XF_REPEAT_SEPARATOR + "1");
            rte = Page.getControl(container);
            rte.onRendered(__bind(function() {
              this.resume();
              return Assert.areEqual("Inside iteration", rte.getValue());
            }, this));
            return this.wait();
          }
        ]
      ]);
    }
  }));
  ORBEON.xforms.Events.orbeonLoadedEvent.subscribe(function() {
    if (parent && parent.TestManager) {
      return parent.TestManager.load();
    } else {
      new YAHOO.tool.TestLogger();
      return YAHOO.tool.TestRunner.run();
    }
  });
}).call(this);
