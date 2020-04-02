// $(document).on('turbolinks:load', function() {
//     let dataAttributes = $('body').data();
//     let controller = camelize(dataAttributes.controller);
//     let controllerAction = camelize(dataAttributes.controllerAction);
//     if (controller in loader && controllerAction in loader[controller]) {
//         loader[controller][controllerAction]();
//         console.log("loader[" + controller + "][" + controllerAction + "]")
//     } else if (controller in loader && controllerAction + 'Action' in loader[controller]) {
//         loader[controller][controllerAction + 'Action']();
//         console.log("loader[" + controller + "][" + controllerAction + "]")
//     }
// });

