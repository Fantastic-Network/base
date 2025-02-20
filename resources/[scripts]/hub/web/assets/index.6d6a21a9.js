import{r as d,b as n,U as P,j as o,V as I,W as A,w as i,E as y,x as b,J as R,G as k,u as C,g as u,A as G,F as E}from"./index.290eb4ce.js";import{b as S}from"./index.esm.bfe53b6f.js";function T(t){const[a,g]=d.exports.useState(""),[w,p]=d.exports.useState([]),[s,c]=d.exports.useState(!1);return d.exports.useEffect(()=>{t.list&&(g(t.selected||""),p(t.list))},[]),n(P,{children:[o("p",{children:a}),o(I,{onClick:()=>c(!s),children:o(S,{color:"white",style:{rotate:s?"-180deg":"0deg"}})}),s&&o(A,{children:w&&w.map((h,f)=>o("div",{onClick:()=>{t.callback(h),c(!1),g(h)},children:h},f))})]})}const N=i.div`
  width: 52.917vw;
  height: 100%;
  display: flex;
  background: rgba(0, 0, 0, 0.5);
`,z=i.div`
  width: 16.094vw;
  height: 100%;
  background: ${({theme:t})=>"url(./assets/background-left.png)"};
  background-size: 100% 100%;
  border-radius: 0.25vw;
  display: flex;
  flex-direction: column;
  align-items: center;
`,D=i.p`
  font-weight: 500;
  font-size: 0.825vw;
  line-height: 1.25vw;
  color: #fff;
  margin-top: 1.5vw;
`,L=i.div`
  width: 14.01vw;
  height: 100%;
  margin-top: 1.823vw;
  display: flex;
  flex-wrap: wrap;
  align-content: flex-start;
  gap: 0.341vw;
  overflow-y: auto;
`,$=i.div`
  width: 97%;
  height: 2.003vw;
  padding: 0 1vw;
  background: rgba(0, 0, 0, 0.71);
  border-radius: 0.25vw;
  display: flex;
  align-items: center;
  font-weight: 500;
  font-size: 0.725vw;
  line-height: 1vw;
  color: #fff;
  cursor: pointer;
  transition: all ease 0.4s;
  border: 0.05vw ridge transparent;

  ${({actived:t})=>t?y`
          background: ${({theme:a})=>a.colors["main-opacity"][200]};
          border: 0.05vw ridge ${({theme:a})=>a.colors.main[500]};
        `:y`
          &:hover {
            opacity: 0.5;
          }

          &:active {
            opacity: 1;
          }
        `}
`,j=i.div`
  width: 100%;
  margin: 1.9vw;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.469vw;

  p {
    font-weight: 400;
    font-size: 0.725vw;
    line-height: 1vw;
    color: rgba(255, 255, 255, 0.5);
  }
`;i.div`
  width: 10.925vw;
  height: 1.5vw;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  position: relative;
  border-radius: 0.25vw 0.25vw 0 0;

  p {
    font-weight: 500;
    font-size: 0.825vw;
    line-height: 1.25vw;
    color: #fff;
  }
`;i.div`
  width: 1.771vw;
  height: 1.54vw;
  position: absolute;
  right: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  transition: all ease 0.4s;

  &:hover {
    opacity: 0.5;
  }

  &:active {
    opacity: 1;
  }

  img {
    width: 0.7vw;
  }
`;i.div`
  width: 100%;
  background: rgba(0, 0, 0, 0.5);
  position: absolute;
  bottom: 0;
  transform: translate(0, 100%);
  border-radius: 0 0 0.25vw 0.25vw;

  div {
    width: 100%;
    height: 1.5vw;
    display: flex;
    justify-content: center;
    align-items: center;
    font-weight: 500;
    font-size: 0.825vw;
    line-height: 1.25vw;
    color: #fff;
    cursor: pointer;
    transition: all ease 0.4s;

    &:hover {
      background: rgba(0, 0, 0, 0.8);
    }

    &:active {
      background: rgba(0, 0, 0, 0.2);
    }
  }
`;const V=i.div`
  width: 36.823vw;
  height: 100%;
  padding: 1.25vw;
  display: flex;
  flex-wrap: wrap;
  align-content: flex-start;
  gap: 0.313vw;
  overflow: auto;

  &::-webkit-scrollbar {
    display: none;
  }
`,F=i(b.div)`
  width: 100%;
  height: 5.729vw;
  background: rgba(0, 0, 0, 0.5);
  border-radius: 0.417vw;
  position: relative;
  display: flex;
  align-items: center;
`,B=i.div`
  width: 4.27vw;
  height: 100%;
  background: rgba(0, 0, 0, 0.51);
  border-radius: 0.415vw 0vw 0vw 0.415vw;
  font-weight: 500;
  font-size: 1.875vw;
  line-height: 2.8125vw;
  color: #fff;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-right: 1.145vw;

  svg {
    font-size: 2.15vw;
    color: ${({theme:t})=>t.colors.main[500]};
  }
`,q=i(R)`
  width: 8.425vw;
  height: 2.6vw;
  position: absolute;
  right: 1.615vw;
  font-weight: 500;
  font-size: 0.625vw;
  line-height: 0.925vw;
  transition: all ease 0.4s;
`,O=i.div`
  width: 57%;
  display: flex;
  flex-direction: column;
  gap: 0.365vw;
  opacity: ${t=>t.completed?.3:1};
`,M=i.p`
  font-weight: 600;
  font-size: 0.725vw;
  line-height: 1vw;
  color: #fff;
`,U=i.p`
  font-weight: 400;
  max-height: 2vw;
  max-width: 18vw;
  overflow: auto;
  overflow-x: hidden;
  font-size: 0.625vw;
  line-height: 0.925vw;
  color: rgba(255, 255, 255, 0.5);
`,Y=i.div`
  width: 12.5vw;
  height: 0.25vw;
  background: rgba(255, 255, 255, 0.12);
  border-radius: 0.104vw;
  margin: 0.5vw 0;
  position: relative;
  display: flex;
  align-items: center;

  &::after {
    content: '${t=>t.text}';
    color: #fff;
    position: absolute;
    right: -0.26vw;
    transform: translate(100%);
    font-weight: 400;
    font-size: 0.625vw;
    line-height: 0.925vw;
    color: rgba(255, 255, 255, 0.5);
  }
`,_=i.div`
  width: ${t=>t.porcentage+"%"};
  height: 100%;
  background: ${t=>t.theme.colors["main-opacity"][500]};
  border-radius: 0.104vw;
`,H=i.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 7vw;
  position: relative;
`,J=i.p`
  font-weight: 600;
  font-size: 0.725vw;
  color: #fff;
`,K=i.p`
  font-weight: 600;
  font-size: 0.725vw;
  color: rgba(255, 255, 255, 0.5);
`,W=i.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  overflow: auto;
  max-height: 3vw;
  padding-right: 0.5vw;
`,Z={achievementsGroups:["PVP","ROLEPLAY","VISITAS","EVENTOS"],achievements:[{Group:"ROLEPLAY",Redeemed:!1,Progress:1,Name:"Armado e perigoso com arma de fogo",Completed:!0,GroupID:3,PlayerProgress:1,Rewards:[{type:"Item",name:"Pistola",amount:1}],Description:"Equipe uma arma"},{Group:"VISITAS",Redeemed:!1,Progress:1,Name:"Armado e perigoso",Completed:!0,GroupID:3,PlayerProgress:1,Rewards:[{type:"Item",name:"Pistola",amount:1}],Description:"Equipe uma arma"},{Group:"VISITAS",Redeemed:!1,Progress:1,Name:"Armado e malandro",Completed:!1,GroupID:3,PlayerProgress:1,Rewards:[{type:"Item",name:"Pistola",amount:1}],Description:"Equipe uma arma"},{Group:"PVP",Redeemed:!1,Progress:1,Name:"Armado e perigoso",Completed:!0,GroupID:3,PlayerProgress:1,Rewards:[{type:"Item",name:"Pistola",amount:1}],Description:"Equipe uma arma"},{Group:"PVP",Redeemed:!1,Progress:1,Name:"Armado e perigoso",Completed:!1,GroupID:3,PlayerProgress:1,Rewards:[{type:"Item",name:"Pistola",amount:1}],Description:"Equipe uma arma"}],titles:["Guerreiro",""],selectedTitle:""};function Q(t){return k({tag:"svg",attr:{viewBox:"0 0 24 24"},child:[{tag:"path",attr:{d:"M21.03 5.72a.75.75 0 0 1 0 1.06l-11.5 11.5a.747.747 0 0 1-1.072-.012l-5.5-5.75a.75.75 0 1 1 1.084-1.036l4.97 5.195L19.97 5.72a.75.75 0 0 1 1.06 0Z"}}]})(t)}function te(){const{t}=C(),[a,g]=d.exports.useState({}),[w,p]=d.exports.useState(""),[s,c]=d.exports.useState([]);d.exports.useEffect(()=>{u("getAchievements",{},Z).then(e=>{g(e),p(e.achievementsGroups[0]),c([...e.achievements].filter(r=>r.Group===e.achievementsGroups[0]).sort((r,l)=>Number(r.Redeemed)-Number(l.Redeemed)))})},[]);const h=e=>{p(e),c([...a.achievements].filter(r=>r.Group===e).sort((r,l)=>Number(r.Redeemed)-Number(l.Redeemed)))},f=e=>{u("redeemAchievement",{name:e},!0).then(r=>{const l=[...s].findIndex(v=>v.Name===e),m=[...s];m[l].Redeemed=!0,c(m)})},x=e=>{u("editTitle",{new_title:e})};return n(N,{as:b.div,initial:{opacity:0},animate:{opacity:1},exit:{opacity:0},children:[n(z,{children:[o(D,{children:t("titleAchievements")}),o(L,{children:a.achievementsGroups&&a.achievementsGroups.map((e,r)=>o($,{onClick:()=>h(e),actived:e===w,children:e},r))}),n(j,{children:[o("p",{children:t("disponibleAchievements")}),a.titles&&o(T,{callback:e=>x(e),selected:a.selectedTitle,list:a.titles})]})]}),o(V,{children:o(G,{children:s&&s.map((e,r)=>{var l;return n(F,{initial:{opacity:0},animate:{opacity:1},exit:{opacity:0},layout:!0,transition:{duration:.2},children:[o(B,{children:e.Redeemed?o(Q,{}):o(E,{children:r+1})}),n(O,{completed:e.Redeemed,children:[o(M,{children:e.Name}),o(U,{children:e.Description}),o(Y,{text:(e.PlayerProgress||"0")+"/"+e.Progress,children:o(_,{porcentage:e.PlayerProgress*100/e.Progress})})]}),!e.Redeemed&&e.Completed&&o(q,{onClick:()=>f(e.Name),children:t("redeemAchievement")}),!e.Redeemed&&!e.Completed&&n(H,{children:[n(J,{children:[t("rewardAchievement"),":"]}),o(W,{children:(l=e.Rewards)==null?void 0:l.map((m,v)=>n(K,{children:[m.name," ",m.amount&&`x${m.amount}`]}))})]})]},r)})})})]})}export{te as default};
