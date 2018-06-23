// TypeScript file
var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var __extends = this && this.__extends || function __extends(t, e) { 
 function r() { 
 this.constructor = t;
}
for (var i in e) e.hasOwnProperty(i) && (t[i] = e[i]);
r.prototype = e.prototype, t.prototype = new r();
};
var BasicConcept = (function (_super) {
    __extends(BasicConcept, _super);
    function BasicConcept() {
        var _this = _super.call(this) || this;
        _this.createView();
        _this.drawGrid();
        return _this;
    }
    BasicConcept.prototype.createView = function () {
        var shape = new egret.Shape();
        // this.addChild(shape);
        shape.x = 100;
        shape.y = 20;
        shape.scaleX = 0.5;
        // shape.
        shape.scaleY = 0.5;
        shape.alpha = 0.4;
        shape.rotation = 30;
        shape.width = 300;
        shape.height = 300;
        console.log("进入了着了");
    };
    BasicConcept.prototype.drawGrid = function () {
        this.graphics.beginFill(0x0000ff);
        this.graphics.drawRect(0, 0, 50, 50);
        this.graphics.endFill();
        this.graphics.beginFill(0x0000ff);
        this.graphics.drawRect(150, 150, 50, 50);
        this.graphics.endFill();
        this.graphics.beginFill(0x0000ff);
        this.graphics.drawRect(150, 0, 50, 50);
        this.graphics.endFill();
        this.graphics.beginFill(0x0000ff);
        this.graphics.drawRect(0, 150, 50, 50);
        this.graphics.endFill();
    };
    return BasicConcept;
}(egret.Shape));
__reflect(BasicConcept.prototype, "BasicConcept");
//# sourceMappingURL=BasicConcept.js.map