(function() {
  var Events;
  Events = ORBEON.xforms.Events;
  $(function() {
    var setPlaceholderImage;
    setPlaceholderImage = function() {
      var spacer;
      spacer = '/ops/images/xforms/spacer.gif';
      return $("#fr-form-group .fb-upload img.xforms-output-output[src $= '" + spacer + "']").each(function(index, image) {
        var prefix;
        prefix = image.src.substr(0, image.src.indexOf(spacer));
        return image.src = prefix + '/apps/fr/style/images/silk/photo.png';
      });
    };
    setPlaceholderImage();
    return Events.ajaxResponseProcessedEvent.subscribe(setPlaceholderImage);
  });
}).call(this);