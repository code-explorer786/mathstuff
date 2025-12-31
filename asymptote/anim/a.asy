import animation;

animation a;

// grid size, we're putting the actual cars in 
int h = 10;
int w = 10;
int numcars = 10;
usersetting();

size(10 * w,10 * h);

picture grid;
picture grid2;
picture carpic;

int[] dirx = {1,0,-1,0};
int[] diry = {0,1,0,-1};

struct Car {
    pair src;
    pair dst;
    int rot; // out of 4
    void set(pair newdst){
        this.src = this.dst;
        this.dst = newdst;
    }
    void step(){
        this.dst = this.src + (dirx[rot], diry[rot]);
    }
    void skip(){
        if (this.rot == 0){
            this.dst = (w - 1, this.src.y);
        } else if (this.rot == 2){
            this.dst = (0, this.src.y);
        } else if (this.rot == 3){
            this.dst = (this.src.x, 0);
        } else if (this.rot == 1){
            this.dst = (this.src.x, h - 1);
        }
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

void snapshot(picture curgrid=grid2, real prog, int frames){
    save();

    add(curgrid);
    for(Car i : cars){
        i.draw(prog);
    }

    for(int i = 0; i < frames; ++i){
        a.add();
    }
    restore();
}

// Cars!
// counterclockwise
// 0: right, 1: up, 2: left, 3: down
// there are no two cars facing each other
// we check by tracking minimum/maximum car on each row/column according to their rotation

int[][] filled = array(h + 1, array(w + 1, 0));
int[][] filleddir = {array(h+1,w+1), array(w+1,h+1), array(h+1,-1), array(w+1,-1)};

bool valid(pair pos, int rot){
    write(stdout,"",endl);
    write(stdout,"pos ",pos,endl);
    write(stdout,"rot ",rot,endl);
    int x = round(pos.x);
    int y = round(pos.y);
    if (filled[y][x] != 0 || filled[y + diry[rot]][x + dirx[rot]] == 1) {
        return false;
    }

    int sign = (rot == 0 || rot == 1) ? 1 : -1;
    int check = (rot == 0 || rot == 2) ? x : y;
    int idx = (rot == 0 || rot == 2) ? y : x;
    write(stdout,"sign ",sign,endl);
    write(stdout,"check ",check,endl);
    write(stdout,"idx ",idx,endl);
    write(stdout,"checkedto ",filleddir[XOR(rot,2)][idx],endl);
    if (sign * filleddir[XOR(rot,2)][idx] > sign * check) {
        return false;
    }

    write(stdout,"SUCCESS",endl);

    filled[y][x] = 1;
    filled[y + diry[rot]][x + dirx[rot]] = 2;
    write(stdout,"check ",check,endl);
    write(stdout,"checkedto ",filleddir[rot][idx],endl);
    if (sign * filleddir[rot][idx] > sign * check) {
        filleddir[rot][idx] = check;
        write(stdout,"OVERWRITTEN",endl);
    }

    return true;
}

int randskew(int a, int b, int skew){
    real init = unitrand();
    // init = (skew == 0) ? init : (skew < 0) ? init * init : 1 - (1 - init) * (1 - init);
    init = erf(init);
    return a + floor((b-a+2) * init);
}

// pair[] testpos = {(3,2), (3,5), (2,3), (5,3), (6,3)};
// int[] testrot =  {1,     3,     0,     2,     0};
// 
// for(int i = 0; i < testpos.length; ++i){
//     if(valid(testpos[i], testrot[i])){
//         cars.push(newCar(testpos[i],testpos[i],testrot[i]));
//     }
//     snapshot(1.0);
// }

for(int i = 0; i < numcars; ++i){
    pair pos;
    int rot;
    do {
        rot = rand(0,3);
        // pos = (rand(1,w-2), rand(1,h-2));
        pos = (randskew(2,w-3,dirx[rot]),randskew(2,h-3,diry[rot]));
    } while (!valid(pos,rot));
    cars.push(newCar(pos,pos,rot));
    snapshot(grid,1.0,1);
}

// add(grid2);
// for(Car i : cars){
//     i.draw(1.0);
// }

// MAIN PROBLEM SOLUTION
snapshot(grid,0.0,30);
snapshot(grid2,0.0,30);

// Move the [<]/[>] cars on the gray columns to the white columns.
// Note that they must never collide then;
// if they do, that means there were originally two cars facing each other.
for(Car i : cars){
    i.done();
    if((i.rot == 0 || i.rot == 2) && round(i.src.x) % 2 == 0){
        i.step();
    }
}
for(real i = 0.0; i <= 1.0; i += 1/30){
    snapshot(i,1);
}
snapshot(1.0,15);

// The [^]/[v] cars on the gray columns are now free.
for(Car i : cars){
    i.done();
    if((i.rot == 1 || i.rot == 3) && round(i.src.x) % 2 == 0){
        i.skip();
    }
}
for(real i = 0.0; i <= 1.0; i += 1/30){
    snapshot(i,1);
}
snapshot(1.0,15);

// Move all [<]/[>] cars. They must end up in gray columns.
for(Car i : cars){
    i.done();
    if((i.rot == 0 || i.rot == 2) && round(i.src.x) % 2 == 1){
        i.step();
    }
}
for(real i = 0.0; i <= 1.0; i += 1/30){
    snapshot(i,1);
}
snapshot(1.0,15);

// The [^]/[v] cars on the white columns are now free.
for(Car i : cars){
    i.done();
    if((i.rot == 1 || i.rot == 3) && round(i.src.x) % 2 == 1){
        i.skip();
    }
}
for(real i = 0.0; i <= 1.0; i += 1/30){
    snapshot(i,1);
}
snapshot(1.0,15);

// The [<]/[>] cars are now free.
for(Car i : cars){
    i.done();
    if((i.rot == 0 || i.rot == 2)){
        i.skip();
    }
}
for(real i = 0.0; i <= 1.0; i += 1/30){
    snapshot(i,1);
}
snapshot(1.0,15);

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
