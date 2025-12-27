import animation;

size(100,100);

animation a;

// grid size, we're putting the actual cars in 
int h = 10;
int w = 10;
int numcars = 10;
usersetting();

picture grid;
picture grid2;
picture carpic;

struct Car {
    pair src;
    pair dst;
    int rot; // out of 4
    void set(pair newdst){
        this.src = this.dst;
        this.dst = newdst;
    }
    void done(){
        this.src = this.dst;
    }
    pair now(real prog){
        return interp(src,dst,sin(pi/2*prog));
    }
    void draw(picture dest=currentpicture, real prog){
        add(dest,rotate(90*rot) * carpic,now(prog) + (0.5,0.5));
    }
}

Car[] cars;

Car newCar(pair src, pair dst, int rot){
    Car c = new Car;
    c.src = src;
    c.dst = dst;
    c.rot = rot;
    return c;
}

// Initialize the grid where we're moving the cars
save();
// Draw axis lines
for(int i = 0; i <= w; ++i) {
    draw((i,0) -- (i,h));
}
for(int j = 0; j <= h; ++j) {
    draw((0,j) -- (w,j));
}
add(grid, currentpicture);
restore();

save();
for(int i = 0; i < w; i += 2) {
    fill(box((i,0),(i+1,w)), currentpen + mediumgray);
}
add(grid2,currentpicture);
add(grid2,grid);
restore();

// Car facing east
size(carpic,7,7);
save();
draw(box((-1/2,3/8),(1/2,-3/8)));
draw((rotate(0) * (1/4,0) -- rotate(120) * (1/4,0) -- rotate(240) * (1/4,0) -- cycle));
add(carpic, currentpicture);
restore();

// Cars!

pair dir(int rot){
    if(rot == 0) {
        return (1,0);
    } else if(rot == 1) {
        return (0,1);
    } else if(rot == 2) {
        return (-1, 0);
    } else if(rot == 3) {
        return (0, -1);
    }
    return (0,0);
}

bool[][] filled = array(h + 1, array(w + 1, false));
for(int i = 0; i < numcars; ++i){
    pair pos;
    int rot;
    pair pos2;
    do {
        pos = (rand(1,w-2),rand(1,h-2));
        rot = rand(0,3);
        pos2 = pos + dir(rot);
    } while (filled[floor(pos.y)][floor(pos.x)] || filled[floor(pos2.y)][floor(pos2.x)]);
    cars.push(newCar((w/2,h/2) + rotate(90 * rot) * (w/2 - 1,0),pos,rot));
    filled[floor(pos.y)][floor(pos.x)] = true;
    filled[floor(pos2.y)][floor(pos2.x)] = true;
}

// add(grid2);
// for(Car i : cars){
//     i.draw(1.0);
// }

void snapshot(picture curgrid=grid2, real prog){
    save();

    add(curgrid);
    for(Car i : cars){
        i.draw(prog);
    }

    a.add();
    restore();
}

for(real i = 0.0; i <= 1.0; i += 1/60){
    snapshot(i);
}

a.movie(loops=10,delay=50);

// void face(face[] faces, path3 p, int j, int k) {
//   picture pic=faces.push(p); filldraw(pic,project(p),Pen(j));
//   int sign=(k % 2 == 0) ? 1 : -1;
//   transform t=scale(4)*transform(dir(p,0,sign),dir(p,0,-sign));
//   label(pic,t*(string) j,project(0.5*(min(p)+max(p))));
// }
// 
// void snapshot(transform3 t)
// {
//   static transform3 s=shift(-0.5*(X+Y+Z));
//   save();
//   
//   face[] faces;
//   int j=-1;
//   transform3 T=t*s;
//   for(int k=0; k < 2; ++k) {
//     face(faces,T*plane((1,0,0),(0,1,0),(0,0,k)),++j,k);
//     face(faces,T*plane((0,1,0),(0,0,1),(k,0,0)),++j,k);
//     face(faces,T*plane((0,0,1),(1,0,0),(0,k,0)),++j,k); 
//   }
//   add(faces);
//   
//   a.add();
//   restore();
// }
// 
// int n=50;
// 
// real step=360/n;
// for(int i=0; i < n; ++i)
//   snapshot(rotate(i*step,X));
// for(int i=0; i < n; ++i)
//   snapshot(rotate(i*step,Y));
// for(int i=0; i < n; ++i)
//   snapshot(rotate(i*step,Z));
// 
// a.movie(loops=10,delay=50);
