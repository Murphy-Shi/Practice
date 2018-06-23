// TypeScript file

class BasicConcept extends egret.Shape{
    public constructor(){
        super();
        this.createView();
        this.drawGrid();
    }

    private createView(){
        var shape:egret.Shape = new egret.Shape();
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
    }

    private drawGrid(){
        this.graphics.beginFill( 0x0000ff );
        this.graphics.drawRect( 0, 0, 50, 50);
        this.graphics.endFill();
        this.graphics.beginFill( 0x0000ff );
        this.graphics.drawRect( 150, 150, 50, 50);
        this.graphics.endFill();
        this.graphics.beginFill( 0x0000ff );
        this.graphics.drawRect( 150, 0, 50, 50);
        this.graphics.endFill();
        this.graphics.beginFill( 0x0000ff );
        this.graphics.drawRect( 0, 150, 50, 50);
        this.graphics.endFill();
    }
}