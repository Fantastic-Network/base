import{w as a,x as q,E as p,J as R,K as b,u as y,b as l,j as o,e as $,F as B,r as g,f as A,a as S,g as u,L as F,M as k}from"./index.290eb4ce.js";import{I as z,a as j}from"./index.esm.bfe53b6f.js";const C=a(q.div)`
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  gap: 0.781vw;
`,M=a.div`
  width: 100%;
  height: 14.323vw;
  background: ${({theme:e})=>`url(./assets/dynamic/fronteira/battlepass/background-top.png)`};
  background-size: 100% 100%;
  padding: 0 2.656vw;
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: center;

  .indicators {
    position: absolute;
    right: 1.35vw;
    bottom: 1.5vw;
    display: flex;
    gap: 0.315vw;
  }
`,D=a.p`
  font-weight: 400;
  font-size: 2vw;
  line-height: 2.135vw;
  color: #fff;
  text-transform: uppercase;

  span {
    font-weight: 700;
  }
`,K=a.div`
  display: flex;
  align-items: center;
  gap: 0.315vw;
  font-weight: 400;
  font-size: 0.825vw;
  line-height: 2.135vw;
  color: rgba(255, 255, 255, 0.5);
`,O=a.img`
  height: 0.825vw;
`,V=a(R)`
  width: 15vw;
  height: 2.5vw;
  margin-top: 1.5vw;
  font-size: 0.825vw;
  line-height: 1.25vw;
`,H=a.div`
  width: 15.104vw;
  height: 0.417vw;
  background: ${({theme:e})=>e.colors["main-opacity"][200]};
  border: 0.05vw ridge ${({theme:e})=>e.colors.main[500]};
  margin-top: 2.813vw;
  position: relative;

  &::after {
    content: '${({level:e})=>`${e}`}';
    font-weight: 400;
    font-size: 1vw;
    line-height: 2.135vw;
    color: #fff;
    position: absolute;
    bottom: 0.313vw;
    transform: translate(0%);
  }

  &::before {
    content: '${({percentage:e})=>e&&`${e.toFixed(0)}/100`}';
    font-weight: 400;
    font-size: 0.625vw;
    line-height: 2.135vw;
    color: rgba(255, 255, 255, 0.5);
    position: absolute;
    right: 0;
    bottom: 0.313vw;
    transform: translate(0%);
  }

  .bar {
    width: ${({percentage:e})=>e&&`${e}%`};
    height: 100%;
    background: ${({theme:e})=>e.colors.main[500]};
  }
`,J=a(R)`
  width: 15.104vw;
  height: 2.5vw;
  position: absolute;
  right: 1.354vw;
  top: 2.135vw;
  font-weight: 500;
  font-size: 0.825vw;
  line-height: 1.25vw;
`;a.img`
  width: 0.327vw;
  height: 0.588vw;
`;a.img`
  width: 0.327vw;
  height: 0.588vw;
  -moz-transform: scaleX(-1);
  -o-transform: scaleX(-1);
  -webkit-transform: scaleX(-1);
  transform: scaleX(-1);
`;const W=a.div`
  width: 100%;
  height: 17.188vw;
  display: flex;
  align-content: flex-start;
  flex-direction: column;
  flex-wrap: wrap;
  gap: 0.365vw;
  overflow: hidden;
`,L=a.div`
  display: flex;
  flex-direction: column;
  gap: 0.315vw;

  width: 7.65vw;
  max-width: 7.65vw;
  min-width: 7.65vw;
  height: 100%;

  font-weight: 500;
  font-size: 0.625vw;
  line-height: 2.135vw;
  color: #fff;
  text-transform: uppercase;
`,G=a(b)`
  width: 100%;
  height: 7.75vw;
  font-weight: 400;
  font-size: 1vw;
  line-height: 2.135vw;

  p span {
    font-weight: 700;
    color: ${({theme:e})=>e.colors.main[500]};
  }
`,Q=a.div`
  width: 100%;
  height: 7.75vw;
  background: rgba(0, 0, 0, 0.7);
  border-radius: 0.25vw;
  display: flex;
  justify-content: center;
  align-items: center;
  font-weight: 400;
  font-size: 1vw;
  line-height: 2.135vw;
  gap: 0.25vw;

  p span {
    font-weight: 700;
  }
`,T=a.div`
  width: 100%;
  height: 1.15vw;

  background: ${({theme:e})=>e.colors["main-opacity"][500]};
  color: #fff;

  border-radius: 0.25vw;
  display: flex;
  justify-content: center;
  align-items: center;

  ${({isBlocked:e,isDefault:t})=>(e||t)&&p`
    background: rgba(0, 0, 0, 0.7);
    color: rgba(255, 255, 255, 0.2);
  `}

  ${({received:e})=>e&&p`
    opacity: 0.8;
  `}
`,U={timer:1669744670,battlepass_buy_link:"https://www.discord.com",level:2,xp:1080,hasPremium:!0,Free:[{Level:1,Experience:500,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Received:!0,Reward:{dollars:4324}},{Level:2,Experience:1e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:3,Experience:1e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:4,Experience:1500,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:5,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:6,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:7,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:8,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:9,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:10,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:11,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:12,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:13,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:14,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:15,Experience:500,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:16,Experience:1e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:17,Experience:1e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:18,Experience:1500,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:19,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:20,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:21,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:22,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:23,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:24,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:25,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:26,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:27,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:28,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}}],Premium:[{Level:1,Experience:500,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:323}},{Level:2,Experience:1e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:3,Experience:1e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:4,Experience:1500,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:5,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:6,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:7,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:8,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:9,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:10,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:11,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:12,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:13,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:14,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:15,Experience:500,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:16,Experience:1e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:17,Experience:1e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:18,Experience:1500,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:19,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:20,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:21,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:22,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:23,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:24,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:25,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:26,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:27,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}},{Level:28,Experience:2e3,Type:"Item",Name:"Xesquedele",Photo:"https://cdn.discordapp.com/attachments/971131612668497981/1042869431925211146/glock_2.png",Reward:{dollars:1e3}}]};function Y(e){const t=Date.now(),c=Number(e)*1e3,i=Math.abs(c-t);return Math.floor(i/(1e3*60*60*24))}const I=(e,t)=>({level:e.Level,experience:e.Experience,name:e.Name,reward:{amount:Object.values(e.Reward)[0],type:Object.keys(e.Reward)[0]},image:e.Photo,redeemed:e.Received,...t}),Z=e=>{let t=e.xp*100/500;const c=e.Free.map(s=>I(s,{isPremium:!1})),i=e.Premium.map(s=>I(s,{isPremium:!0})),d=Y(e.timer);if(e.level>0){const s=c.find(m=>m.level===e.level);if(s){const m=s.experience;t=(e.xp-m)/100}}return{timer:e.timer,buyLink:e.battlepass_buy_link,hasPremium:e.hasPremium,level:e.level,xp:e.xp,freeItems:c,premiumItems:i,percentage:t,days:d}},ee=a.div`
  width: 100%;
  height: 7.75vw;
  border-radius: 0.25vw;
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  background: ${({isPremium:e,theme:t})=>e?t.colors["main-opacity"][200]:`linear-gradient(180deg, ${t.colors["main-opacity"][300]} 0%, ${t.colors["main-opacity"][500]} 100%)`};

  ${({blocked:e})=>e&&p`
    background: rgba(0, 0, 0, 0.2);
    border: 0.05vw ridge transparent;

    img {
      opacity: 0.5;
    }
  `}

  ${({redeemed:e})=>e&&p`
    opacity: 0.8;
  `}

  &::after {
    content: ${({reward:e})=>`'${e.amount}x'`};
    height: 0.925vw;
    padding: 0.1vw 0.3vw;
    ${({blocked:e})=>e?p`
      background: rgba(0, 0, 0, 0.2);
      color: rgba(255, 255, 255, 0.2);
    `:p`
      background: ${({theme:t})=>t.colors["main-opacity"][400]};
      color: #fff;
    `}
    border-radius: 0.26vw 0vw 0vw 0.26vw;
    position: absolute;
    right: 0;
    top: 4.01vw;
    display: flex;
    justify-content: center;
    align-items: center;
    font-weight: 500;
    font-size: 0.625vw;
    line-height: 2.135vw;
  }
`,te=a.div`
  width: 90%;
  height: 1.5vw;
  background: ${({theme:e})=>`linear-gradient(180deg, ${e.colors["main-opacity"][200]} 0%, ${e.colors["main-opacity"][400]} 100%)`};
  border-radius: 0.25vw;
  position: absolute;
  bottom: 0.365vw;
  font-weight: 500;
  text-transform: uppercase;
  font-size: 0.625vw;
  line-height: 0.925vw;
  color: #fff;
  display: flex;
  justify-content: center;
  align-items: center;
  transition: all 0.2s;

  ${({blocked:e,redeemed:t,isPremium:c,hasPremium:i,theme:d})=>e||t||c&&!i?p`
    background: rgba(0, 0, 0, 0.2);
    color: rgba(255, 255, 255, 0.2);
    cursor: not-allowed;
    &:hover {
      opacity: 1;
    }
  `:p`
    background: ${c?`linear-gradient(180deg, ${d.colors["main-opacity"][600]} 0%, ${d.colors["main-opacity"][800]} 100%)`:`linear-gradient(180deg, ${d.colors["main-opacity"][200]} 0%, ${d.colors["main-opacity"][400]} 100%)`};
    cursor: pointer;
    &:hover {
      opacity: 0.6;
    }
  `}
`,oe=a.img`
  position: absolute;
  transform: translate(-50%, -50%);
  left: 50%;
  top: 37.5%;
  width: 6.25vw;
  height: 6.25vw;
  object-fit: contain;
`;function P({handleRedeem:e,...t}){const{t:c}=y();return l(ee,{...t,children:[o(oe,{src:t.image}),o(te,{onClick:()=>e(t.isPremium||!1,t.level),...t,children:t.blocked?c("battlepassItemBlocked"):t.redeemed?c("battlepassItemRedeemed"):c("battlepassItemRedeem")})]})}const ae=a.div`
  height: 100%;
`;function ce({battlepass:e,reedemItem:t,setLoaded:c,setInstanceRef:i}){const{t:d}=y(),s=e.freeItems.length,[m,w]=$({slides:{perView:"auto",spacing:10},created(){c(!0),i(w)}});return o(ae,{ref:m,className:"keen-slider",children:[...Array(s+1)].map((x,r)=>o(L,{className:"keen-slider__slide",children:e.freeItems[r]&&l(B,{children:[o(T,{received:e.freeItems[r].redeemed&&e.premiumItems[r].redeemed,isBlocked:e.level<r+1,children:d("battlepassLevel",r+1)}),o(P,{handleRedeem:t,blocked:e.level<r+1,isPremium:!1,hasPremium:e.hasPremium,...e.freeItems[r]}),o(P,{handleRedeem:t,blocked:e.level<r+1,isPremium:!0,hasPremium:e.hasPremium,...e.premiumItems[r]})]})},r))})}function de(){const{t:e}=y(),[t,c]=g.exports.useState(null),[i,d]=g.exports.useState(!1),[s,m]=g.exports.useState(null),w=A(),{cityName:x}=S();g.exports.useEffect(()=>{u("getBattlepass",{},U).then(n=>{const h=Z(n);c(h)})},[]);const r=(n,h)=>{if(t===null)return;u("reedemItem",{type:n?"Premium":"Free",level:h},!0).then(_=>{if(!_)return;const v={...t};var f=v.freeItems;n&&(f=v.premiumItems);const E=f.findIndex(X=>X.level===h);f[E].redeemed=!0,c(v)})},N=()=>{u("reedemAll",{},!0).then(n=>{n&&w("/home")})};return t?l(C,{initial:{opacity:0},animate:{opacity:1},exit:{opacity:0},children:[l(M,{children:[o(D,{dangerouslySetInnerHTML:{__html:e("battlepassTitle2","BATTLE")}}),l(K,{children:[o(O,{src:"./assets/icons/clock-icon.svg"}),e("battlepassEndsIn",t.days)]}),!t.hasPremium&&o(V,{onClick:()=>u("buyPass"),children:e("battlepassBuy")}),o(H,{level:e("battlepassLevel",t.level),percentage:t.percentage,children:o("div",{className:"bar"})}),o(J,{onClick:N,children:e("battlepassRedeemAll")}),i&&l("div",{className:"indicators",children:[o(k,{onClick:()=>{var n;return s&&((n=s.current)==null?void 0:n.prev())},children:o(z,{})}),o(k,{onClick:()=>{var n;return s&&((n=s.current)==null?void 0:n.next())},children:o(j,{})})]})]}),l(W,{children:[l(L,{children:[o(T,{isDefault:!0,children:e("passText")}),l(G,{children:["FREE ",o("span",{children:"PASS"})]}),l(Q,{children:["VIP ",o("span",{children:"PASS"})]})]}),o(ce,{battlepass:t,reedemItem:r,setLoaded:d,setInstanceRef:m})]})]}):o(F,{})}export{de as default};
