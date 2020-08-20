package;

import kha.Image;
import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Main {
	static var image:Image;
	static function update(): Void {
	}

	static function render(frames: Array<Framebuffer>): Void {
		if(image==null)return;
		var g2=frames[0].g2;
		g2.begin(true);
		g2.drawImage(image,0,0);
		g2.end();
	}

	public static function main() {
		System.start({title: "Project", width: 1024, height: 768}, function (_) {
			// Just loading everything is ok for small projects
			Assets.loadEverything(function () {
				// Avoid passing update/render directly,
				// so replacing them via code injection works
				Scheduler.addTimeTask(function () { update(); }, 0, 1 / 60);
				System.notifyOnFrames(function (frames) { render(frames); });

				image=Image.createRenderTarget(2048,2048);
				var g2=image.g2;
				var change:Bool=true;
				g2.begin(true,Color.Blue);
				for(i in 0...5000){
					if(change){
						g2.drawScaledSubImage(Assets.images.RetroCoin,0,0,128,128,Math.random()*2048,Math.random()*2048,128,128);
					}else{
						g2.drawScaledSubImage(Assets.images.RetroFeather,0,0,128,128,Math.random()*2048,Math.random()*2048,128,128);
					}
					change=!change;
				}
				g2.end();
			
			});
		});
	}
}
