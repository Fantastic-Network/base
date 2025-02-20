import{u as x,a as h,r as u,j as t,B as D,A as H,b as r,c as M,F as y,d as $,o as P,C as G,H as B,T as U,N as _,e as S,f as z,g as v,R as A,L as E,h as Q,i as K,k as O,P as p,l as g,m as j,n as Z,G as C,p as F,S as q,I as W,q as I,s as L,t as Y,v as J,w as f,x as X,y as ee,z as te,D as ne}from"./index.290eb4ce.js";function ie(e){function n(s,o){return o=o||2,("00"+s).slice(-o)}var i=e%1e3;e=(e-i)/1e3;var c=e%60;e=(e-c)/60;var a=e%60,l=(e-a)/60;return n(l)+":"+n(a)+":"+n(c)}function se(){return Math.floor(Math.random()*6+3)*60*60*1e3}const re=e=>!e||e.length===0?void 0:e.reduce((i,c)=>i.TimeStamp>c.TimeStamp?c:i);function V(e){let n,i=!1;function c(){clearTimeout(n)}function a(){clearTimeout(n),!i&&(n=setTimeout(()=>{e.next()},3e3))}e.on("created",()=>{e.container.addEventListener("mouseover",()=>{i=!0,c()}),e.container.addEventListener("mouseout",()=>{i=!1,a()}),a()}),e.on("dragStarted",c),e.on("animationEnded",a),e.on("updated",a)}function ae(){const{t:e}=x(),{promotion:n,setFakeTimer:i,fakeTimer:c}=h(),[a,l]=u.exports.useState(!0),[s,o]=u.exports.useState(!1),[w,k]=u.exports.useState("");return u.exports.useEffect(()=>{if(n!=null&&n.hide_timer){o(!0),l(!1);return}let m=c;m||(m=se()+Date.now(),i(m));const d=setInterval(()=>{const R=new Date(m).getTime()-Date.now();if(R<=0){clearInterval(d),o(!1);return}o(!0),k(ie(R)),l(!1)},1e3);return()=>{clearInterval(d)}},[]),t(D,{image:n!=null&&n.image?n.image:"",children:t(H,{children:!a&&r(M,{initial:{opacity:0},animate:{opacity:1},exit:{opacity:0},transition:{duration:.2},children:[s?t(y,{children:!(n!=null&&n.hide_timer)&&t("time",{children:w})}):t("time",{style:{opacity:.75},children:e("promotionExpired")}),t($,{disabled:!s,onClick:()=>P((n==null?void 0:n.link)||""),children:n==null?void 0:n.button_text})]})})})}const oe=[{name:"RANKING ONLINE",description:"Quem passa mais tempo online na cidade?",top:[{name:"Nome do Usu\xE1rio"},{name:"Nome do Usu\xE1rio"},{name:"Nome do Usu\xE1rio"}]},{name:"RANKING PVP",description:"Quem \xE9 o melhor no PVP?",top:[{name:"Nome do Usu\xE1rio"},{name:"Nome do Usu\xE1rio"},{name:"Nome do Usu\xE1rio"}]},{name:"RANKING CORRIDA",description:"Quem \xE9 o melhor no CORRIDA?",top:[{name:"Nome do Usu\xE1rio"},{name:"Nome do Usu\xE1rio"},{name:"Nome do Usu\xE1rio"}]}],N={0:{icon:"./assets/icons/1.svg",color:"#FFD700"},1:{icon:"./assets/icons/2.svg",color:"#FFFFFF"},2:{icon:"./assets/icons/3.svg",color:"#CD7F32"}};function ce({description:e,name:n,top:i,...c}){return r(G,{...c,children:[r(B,{children:[t("h1",{children:n}),t("p",{children:e})]}),t(U,{children:i.map((a,l)=>r(_,{children:[t("img",{src:N[l].icon}),t("p",{style:{width:"16ch",overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap",color:N[l]?N[l].color:"#FFFFFF"},children:a.name})]},l))})]})}function le(){const{t:e}=x(),{ranks:n,setRanks:i}=h(),[c]=S({loop:!0},[V]),a=z(),l=()=>{a("/ranking")};return u.exports.useEffect(()=>{if(n){const s=n.sort(()=>.5-Math.random());i(s);return}v("getRanks",{},oe).then(s=>{const o=s.sort(()=>.5-Math.random());i(o)})},[]),n?r(A,{children:[t("div",{ref:c,className:"keen-slider",children:n.map((s,o)=>t(ce,{className:"keen-slider__slide",...s},o))}),t(Q,{onClick:l,children:e("allRanks")})]}):t(A,{children:t("div",{className:"loading",children:t(E,{})})})}function de(){const{t:e}=x(),{userHasGift:n}=h();return n?t(K,{onClick:()=>{v("setVisible",{visible:!1}),v("getGift",{})},children:t("p",{children:e("gift")})}):t(y,{})}function ue(){const{t:e}=x(),{name:n,phone:i,relationship:c,timePlayed:a,work:l,vip:s}=h(),[o,w]=u.exports.useState(void 0);u.exports.useEffect(()=>{s&&w(re(s))},[s]);const k=z(),m=d=>{if(!!d)return d.Days>0?e("daysLeftVip",d.Days):d.Hours>0?e("hoursLeftVip",d.Hours):d.Minutes>0?e("minutesLeftVip",d.Minutes):e("expiredVip")};return r(O,{children:[r(p,{children:[t("img",{src:"./assets/icons/user.svg"}),t(g,{children:n})]}),r(p,{children:[t("img",{src:"./assets/icons/phone.svg"}),t(g,{children:i})]}),r(p,{children:[t("img",{src:"./assets/icons/passport.svg"}),t(g,{children:c})]}),r(p,{children:[t("img",{src:"./assets/icons/clock.svg"}),r(g,{children:[a," ",e("hoursPlayed")]})]}),r(p,{children:[t("img",{src:"./assets/icons/briefcase.svg"}),t(g,{children:l})]}),r(p,{className:"vip",children:[t("img",{src:"./assets/icons/clock.svg"}),r(g,{children:[o?`${o.Vip} - ${m(o)}`:e("hasntVip"),t(j,{onClick:()=>k("/store"),shouldAnimate:o===void 0?!0:o.Days<5,beRed:o===void 0?!1:o.Days<5,children:e(o?"renewVip":"buyVip")}),o&&t(Z,{className:"hovered-data",children:s==null?void 0:s.map((d,T)=>r("p",{children:[d.Vip," - ",m(d)]},T))})]})]})]})}function me(e){return C({tag:"svg",attr:{viewBox:"0 0 24 24"},child:[{tag:"path",attr:{fill:"none",d:"M0 0h24v24H0z"}},{tag:"path",attr:{d:"M17.77 3.77L16 2 6 12l10 10 1.77-1.77L9.54 12z"}}]})(e)}function he(e){return C({tag:"svg",attr:{viewBox:"0 0 24 24"},child:[{tag:"path",attr:{fill:"none",d:"M0 0h24v24H0V0z"}},{tag:"path",attr:{d:"M6.23 20.23L8 22l10-10L8 2 6.23 3.77 14.46 12z"}}]})(e)}function fe(){const{events:e,setEvents:n}=h(),[i,c]=u.exports.useState(!1),[a,l]=S({initial:0,loop:!0,slides:{perView:3,spacing:15},created(){c(!0)}});return u.exports.useEffect(()=>{e===null&&v("getEvents",{},["https://i.imgur.com/0Q4z1ZS.png","https://i.imgur.com/0Q4z1ZS.png","https://i.imgur.com/0Q4z1ZS.png","https://i.imgur.com/0Q4z1ZS.png","https://i.imgur.com/0Q4z1ZS.png"]).then(n)},[]),e?r(F,{children:[t(q,{ref:a,className:"keen-slider",children:e.map((s,o)=>t(W,{src:s,className:"keen-slider__slide"},o))}),i&&l.current&&r(y,{children:[t(I,{onClick:()=>{var s;return(s=l.current)==null?void 0:s.prev()},className:"left",children:t(me,{})}),t(I,{onClick:()=>{var s;return(s=l.current)==null?void 0:s.next()},className:"right",children:t(he,{})})]})]}):t(F,{children:t(E,{style:{fontSize:"2.5vw"}})})}function pe(){const{streamers:e}=h(),[n,i]=u.exports.useState(null),[c]=S({loop:!0},[V]);return u.exports.useEffect(()=>{if(e){const a=e.sort(()=>.5-Math.random());i(a);return}},[e]),!n||!e?t(L,{children:t(E,{})}):t(L,{children:t(Y,{ref:c,className:"keen-slider",children:n.map((a,l)=>t(J,{className:"keen-slider__slide",image:a.image||"",onClick:()=>P(a.link),children:t("div",{className:"content-wrapper",children:a.name})},l))})})}const ge=f.section`
  width: 100%;
  height: 100%;
`,ve=f.div`
  width: 86.875vw;
  height: 100%;
  display: flex;
  flex-direction: column;
  gap: 1vw;
  position: relative;
`,xe=f.div`
  display: flex;
  gap: 1vw;
  position: relative;
  height: 26.667vw;
  width: 86.875vw;
`,we=f.div`
  flex: 1;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: row;
  gap: 1vw;
`,ke=f.div`
  flex: 1;
  width: 100%;
  height: 100%;
  background-image: ${({theme:e})=>`url(./assets/dynamic/fronteira/org.png)`};
  background-size: cover;
  background-position: center center;
  background-repeat: no-repeat;
  background-color: transparent;

  transition: all 0.4s ease-in-out;
  border-radius: 0.25vw;

  overflow: hidden;
  cursor: pointer;

  position: relative;
  z-index: 2;

  display: flex;
  align-items: flex-end;
  justify-content: center;

  p {
    z-index: 2;
    color: white;
    font-size: 0.9vw;
    text-transform: uppercase;
    font-weight: 600;
    margin-bottom: 1vw;

    transition: all 0.3s;
  }

  .background-anim {
    position: absolute;

    height: 100%;
    width: 100%;
    flex: 1;
    z-index: 1;

    border: 0.1vw ridge ${e=>e.theme.colors.main[500]};
    border-radius: 0.25vw;
    background-color: rgba(0,0,0,0.2);

    transition: all 0.3s;
    opacity: 0;
  }

  &:hover .background-anim {
    opacity: 1;
  }

  &:hover p {
    font-size: 1vw;
  }
`,b=f.div`
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 1vw;
`,Ne=f.button`
  width: 100%;
  height: 4.58vw;
  display: flex;
  border-radius: 0.25vw;
  align-items: center;
  justify-content: center;
  background-image: ${({theme:e})=>`url(./assets/dynamic/fronteira/battlepass.png)`};
  background-size: 105% 105%;
  background-position: center;
  background-color: transparent;
  border: 0.05vw ridge transparent;
  position: relative;
  transition: all 0.4s ease-in-out;

  p {
    position: absolute;
    transform: translate(-50%, -50%);
    left: 45%;
    top: 50%;
    font-weight: 600;
    font-size: 1.875vw;
    color: #fff;
    transition: all 0.4s ease-in-out;
    text-transform: uppercase;
  }

  img {
    position: absolute;
    transform: translate(-50%, 0%);
    left: 65%;
    position: absolute;
    bottom: 0.1vw;
    transition: all 0.4s ease-in-out;
    width: 8.85vw;
    z-index: 3;
  }

  &:hover {
    border: ridge 0.05vw ${e=>e.theme.colors.main[500]};

    p {
      left: 50%;
      font-size: 2vw;
    }

    img {
      left: 85%;
    }
  }
`;function ye(){const{t:e}=x(),{setVisible:n,cityName:i}=h(),c=()=>{v("openFacPanel",{}),n(!1)};return t(ge,{as:X.div,initial:{opacity:0},animate:{opacity:1},exit:{opacity:0},children:r(ve,{children:[t(de,{}),r(xe,{children:[t(ae,{}),r(b,{children:[r(we,{children:[t(le,{}),t(ue,{})]}),t(fe,{})]}),r(b,{children:[t(ee,{}),r(ke,{onClick:c,children:[t("p",{children:e("orgPanel")}),t("div",{className:"background-anim"})]})]}),r(b,{children:[t(te,{}),t(pe,{})]})]}),t(ne,{style:{textDecoration:"none"},to:"/battlepass",children:r(Ne,{children:[t("p",{children:e("battlepassTitle","BATTLE")}),t("img",{src:"./assets/icons/trophy.webp"})]})})]})})}export{ye as default};
