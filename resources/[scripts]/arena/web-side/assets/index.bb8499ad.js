function hf(e,t){return t.forEach(function(n){n&&typeof n!="string"&&!Array.isArray(n)&&Object.keys(n).forEach(function(r){if(r!=="default"&&!(r in e)){var i=Object.getOwnPropertyDescriptor(n,r);Object.defineProperty(e,r,i.get?i:{enumerable:!0,get:function(){return n[r]}})}})}),Object.freeze(Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}))}const mf=function(){const t=document.createElement("link").relList;if(t&&t.supports&&t.supports("modulepreload"))return;for(const i of document.querySelectorAll('link[rel="modulepreload"]'))r(i);new MutationObserver(i=>{for(const o of i)if(o.type==="childList")for(const l of o.addedNodes)l.tagName==="LINK"&&l.rel==="modulepreload"&&r(l)}).observe(document,{childList:!0,subtree:!0});function n(i){const o={};return i.integrity&&(o.integrity=i.integrity),i.referrerpolicy&&(o.referrerPolicy=i.referrerpolicy),i.crossorigin==="use-credentials"?o.credentials="include":i.crossorigin==="anonymous"?o.credentials="omit":o.credentials="same-origin",o}function r(i){if(i.ep)return;i.ep=!0;const o=n(i);fetch(i.href,o)}};mf();var x={exports:{}},W={};/**
 * @license React
 * react.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */var oi=Symbol.for("react.element"),gf=Symbol.for("react.portal"),vf=Symbol.for("react.fragment"),yf=Symbol.for("react.strict_mode"),wf=Symbol.for("react.profiler"),xf=Symbol.for("react.provider"),Cf=Symbol.for("react.context"),kf=Symbol.for("react.forward_ref"),Sf=Symbol.for("react.suspense"),Ef=Symbol.for("react.memo"),Pf=Symbol.for("react.lazy"),ou=Symbol.iterator;function zf(e){return e===null||typeof e!="object"?null:(e=ou&&e[ou]||e["@@iterator"],typeof e=="function"?e:null)}var ic={isMounted:function(){return!1},enqueueForceUpdate:function(){},enqueueReplaceState:function(){},enqueueSetState:function(){}},oc=Object.assign,lc={};function ar(e,t,n){this.props=e,this.context=t,this.refs=lc,this.updater=n||ic}ar.prototype.isReactComponent={};ar.prototype.setState=function(e,t){if(typeof e!="object"&&typeof e!="function"&&e!=null)throw Error("setState(...): takes an object of state variables to update or a function which returns an object of state variables.");this.updater.enqueueSetState(this,e,t,"setState")};ar.prototype.forceUpdate=function(e){this.updater.enqueueForceUpdate(this,e,"forceUpdate")};function ac(){}ac.prototype=ar.prototype;function Za(e,t,n){this.props=e,this.context=t,this.refs=lc,this.updater=n||ic}var Xa=Za.prototype=new ac;Xa.constructor=Za;oc(Xa,ar.prototype);Xa.isPureReactComponent=!0;var lu=Array.isArray,sc=Object.prototype.hasOwnProperty,Ja={current:null},uc={key:!0,ref:!0,__self:!0,__source:!0};function cc(e,t,n){var r,i={},o=null,l=null;if(t!=null)for(r in t.ref!==void 0&&(l=t.ref),t.key!==void 0&&(o=""+t.key),t)sc.call(t,r)&&!uc.hasOwnProperty(r)&&(i[r]=t[r]);var s=arguments.length-2;if(s===1)i.children=n;else if(1<s){for(var u=Array(s),c=0;c<s;c++)u[c]=arguments[c+2];i.children=u}if(e&&e.defaultProps)for(r in s=e.defaultProps,s)i[r]===void 0&&(i[r]=s[r]);return{$$typeof:oi,type:e,key:o,ref:l,props:i,_owner:Ja.current}}function Rf(e,t){return{$$typeof:oi,type:e.type,key:t,ref:e.ref,props:e.props,_owner:e._owner}}function qa(e){return typeof e=="object"&&e!==null&&e.$$typeof===oi}function Lf(e){var t={"=":"=0",":":"=2"};return"$"+e.replace(/[=:]/g,function(n){return t[n]})}var au=/\/+/g;function cl(e,t){return typeof e=="object"&&e!==null&&e.key!=null?Lf(""+e.key):t.toString(36)}function Oi(e,t,n,r,i){var o=typeof e;(o==="undefined"||o==="boolean")&&(e=null);var l=!1;if(e===null)l=!0;else switch(o){case"string":case"number":l=!0;break;case"object":switch(e.$$typeof){case oi:case gf:l=!0}}if(l)return l=e,i=i(l),e=r===""?"."+cl(l,0):r,lu(i)?(n="",e!=null&&(n=e.replace(au,"$&/")+"/"),Oi(i,t,n,"",function(c){return c})):i!=null&&(qa(i)&&(i=Rf(i,n+(!i.key||l&&l.key===i.key?"":(""+i.key).replace(au,"$&/")+"/")+e)),t.push(i)),1;if(l=0,r=r===""?".":r+":",lu(e))for(var s=0;s<e.length;s++){o=e[s];var u=r+cl(o,s);l+=Oi(o,t,n,u,i)}else if(u=zf(e),typeof u=="function")for(e=u.call(e),s=0;!(o=e.next()).done;)o=o.value,u=r+cl(o,s++),l+=Oi(o,t,n,u,i);else if(o==="object")throw t=String(e),Error("Objects are not valid as a React child (found: "+(t==="[object Object]"?"object with keys {"+Object.keys(e).join(", ")+"}":t)+"). If you meant to render a collection of children, use an array instead.");return l}function mi(e,t,n){if(e==null)return e;var r=[],i=0;return Oi(e,r,"","",function(o){return t.call(n,o,i++)}),r}function Nf(e){if(e._status===-1){var t=e._result;t=t(),t.then(function(n){(e._status===0||e._status===-1)&&(e._status=1,e._result=n)},function(n){(e._status===0||e._status===-1)&&(e._status=2,e._result=n)}),e._status===-1&&(e._status=0,e._result=t)}if(e._status===1)return e._result.default;throw e._result}var Be={current:null},Ai={transition:null},Tf={ReactCurrentDispatcher:Be,ReactCurrentBatchConfig:Ai,ReactCurrentOwner:Ja};W.Children={map:mi,forEach:function(e,t,n){mi(e,function(){t.apply(this,arguments)},n)},count:function(e){var t=0;return mi(e,function(){t++}),t},toArray:function(e){return mi(e,function(t){return t})||[]},only:function(e){if(!qa(e))throw Error("React.Children.only expected to receive a single React element child.");return e}};W.Component=ar;W.Fragment=vf;W.Profiler=wf;W.PureComponent=Za;W.StrictMode=yf;W.Suspense=Sf;W.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED=Tf;W.cloneElement=function(e,t,n){if(e==null)throw Error("React.cloneElement(...): The argument must be a React element, but you passed "+e+".");var r=oc({},e.props),i=e.key,o=e.ref,l=e._owner;if(t!=null){if(t.ref!==void 0&&(o=t.ref,l=Ja.current),t.key!==void 0&&(i=""+t.key),e.type&&e.type.defaultProps)var s=e.type.defaultProps;for(u in t)sc.call(t,u)&&!uc.hasOwnProperty(u)&&(r[u]=t[u]===void 0&&s!==void 0?s[u]:t[u])}var u=arguments.length-2;if(u===1)r.children=n;else if(1<u){s=Array(u);for(var c=0;c<u;c++)s[c]=arguments[c+2];r.children=s}return{$$typeof:oi,type:e.type,key:i,ref:o,props:r,_owner:l}};W.createContext=function(e){return e={$$typeof:Cf,_currentValue:e,_currentValue2:e,_threadCount:0,Provider:null,Consumer:null,_defaultValue:null,_globalName:null},e.Provider={$$typeof:xf,_context:e},e.Consumer=e};W.createElement=cc;W.createFactory=function(e){var t=cc.bind(null,e);return t.type=e,t};W.createRef=function(){return{current:null}};W.forwardRef=function(e){return{$$typeof:kf,render:e}};W.isValidElement=qa;W.lazy=function(e){return{$$typeof:Pf,_payload:{_status:-1,_result:e},_init:Nf}};W.memo=function(e,t){return{$$typeof:Ef,type:e,compare:t===void 0?null:t}};W.startTransition=function(e){var t=Ai.transition;Ai.transition={};try{e()}finally{Ai.transition=t}};W.unstable_act=function(){throw Error("act(...) is not supported in production builds of React.")};W.useCallback=function(e,t){return Be.current.useCallback(e,t)};W.useContext=function(e){return Be.current.useContext(e)};W.useDebugValue=function(){};W.useDeferredValue=function(e){return Be.current.useDeferredValue(e)};W.useEffect=function(e,t){return Be.current.useEffect(e,t)};W.useId=function(){return Be.current.useId()};W.useImperativeHandle=function(e,t,n){return Be.current.useImperativeHandle(e,t,n)};W.useInsertionEffect=function(e,t){return Be.current.useInsertionEffect(e,t)};W.useLayoutEffect=function(e,t){return Be.current.useLayoutEffect(e,t)};W.useMemo=function(e,t){return Be.current.useMemo(e,t)};W.useReducer=function(e,t,n){return Be.current.useReducer(e,t,n)};W.useRef=function(e){return Be.current.useRef(e)};W.useState=function(e){return Be.current.useState(e)};W.useSyncExternalStore=function(e,t,n){return Be.current.useSyncExternalStore(e,t,n)};W.useTransition=function(){return Be.current.useTransition()};W.version="18.2.0";x.exports=W;var Y=x.exports,Vl=hf({__proto__:null,default:Y},[x.exports]),Wl={},es={exports:{}},nt={},dc={exports:{}},fc={};/**
 * @license React
 * scheduler.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */(function(e){function t(L,F){var j=L.length;L.push(F);e:for(;0<j;){var re=j-1>>>1,T=L[re];if(0<i(T,F))L[re]=F,L[j]=T,j=re;else break e}}function n(L){return L.length===0?null:L[0]}function r(L){if(L.length===0)return null;var F=L[0],j=L.pop();if(j!==F){L[0]=j;e:for(var re=0,T=L.length,O=T>>>1;re<O;){var A=2*(re+1)-1,D=L[A],S=A+1,G=L[S];if(0>i(D,j))S<T&&0>i(G,D)?(L[re]=G,L[S]=j,re=S):(L[re]=D,L[A]=j,re=A);else if(S<T&&0>i(G,j))L[re]=G,L[S]=j,re=S;else break e}}return F}function i(L,F){var j=L.sortIndex-F.sortIndex;return j!==0?j:L.id-F.id}if(typeof performance=="object"&&typeof performance.now=="function"){var o=performance;e.unstable_now=function(){return o.now()}}else{var l=Date,s=l.now();e.unstable_now=function(){return l.now()-s}}var u=[],c=[],p=1,g=null,m=3,C=!1,y=!1,w=!1,P=typeof setTimeout=="function"?setTimeout:null,f=typeof clearTimeout=="function"?clearTimeout:null,d=typeof setImmediate!="undefined"?setImmediate:null;typeof navigator!="undefined"&&navigator.scheduling!==void 0&&navigator.scheduling.isInputPending!==void 0&&navigator.scheduling.isInputPending.bind(navigator.scheduling);function h(L){for(var F=n(c);F!==null;){if(F.callback===null)r(c);else if(F.startTime<=L)r(c),F.sortIndex=F.expirationTime,t(u,F);else break;F=n(c)}}function k(L){if(w=!1,h(L),!y)if(n(u)!==null)y=!0,Pt(z);else{var F=n(c);F!==null&&Fe(k,F.startTime-L)}}function z(L,F){y=!1,w&&(w=!1,f(b),b=-1),C=!0;var j=m;try{for(h(F),g=n(u);g!==null&&(!(g.expirationTime>F)||L&&!H());){var re=g.callback;if(typeof re=="function"){g.callback=null,m=g.priorityLevel;var T=re(g.expirationTime<=F);F=e.unstable_now(),typeof T=="function"?g.callback=T:g===n(u)&&r(u),h(F)}else r(u);g=n(u)}if(g!==null)var O=!0;else{var A=n(c);A!==null&&Fe(k,A.startTime-F),O=!1}return O}finally{g=null,m=j,C=!1}}var _=!1,M=null,b=-1,V=5,I=-1;function H(){return!(e.unstable_now()-I<V)}function Q(){if(M!==null){var L=e.unstable_now();I=L;var F=!0;try{F=M(!0,L)}finally{F?ne():(_=!1,M=null)}}else _=!1}var ne;if(typeof d=="function")ne=function(){d(Q)};else if(typeof MessageChannel!="undefined"){var me=new MessageChannel,be=me.port2;me.port1.onmessage=Q,ne=function(){be.postMessage(null)}}else ne=function(){P(Q,0)};function Pt(L){M=L,_||(_=!0,ne())}function Fe(L,F){b=P(function(){L(e.unstable_now())},F)}e.unstable_IdlePriority=5,e.unstable_ImmediatePriority=1,e.unstable_LowPriority=4,e.unstable_NormalPriority=3,e.unstable_Profiling=null,e.unstable_UserBlockingPriority=2,e.unstable_cancelCallback=function(L){L.callback=null},e.unstable_continueExecution=function(){y||C||(y=!0,Pt(z))},e.unstable_forceFrameRate=function(L){0>L||125<L?console.error("forceFrameRate takes a positive int between 0 and 125, forcing frame rates higher than 125 fps is not supported"):V=0<L?Math.floor(1e3/L):5},e.unstable_getCurrentPriorityLevel=function(){return m},e.unstable_getFirstCallbackNode=function(){return n(u)},e.unstable_next=function(L){switch(m){case 1:case 2:case 3:var F=3;break;default:F=m}var j=m;m=F;try{return L()}finally{m=j}},e.unstable_pauseExecution=function(){},e.unstable_requestPaint=function(){},e.unstable_runWithPriority=function(L,F){switch(L){case 1:case 2:case 3:case 4:case 5:break;default:L=3}var j=m;m=L;try{return F()}finally{m=j}},e.unstable_scheduleCallback=function(L,F,j){var re=e.unstable_now();switch(typeof j=="object"&&j!==null?(j=j.delay,j=typeof j=="number"&&0<j?re+j:re):j=re,L){case 1:var T=-1;break;case 2:T=250;break;case 5:T=1073741823;break;case 4:T=1e4;break;default:T=5e3}return T=j+T,L={id:p++,callback:F,priorityLevel:L,startTime:j,expirationTime:T,sortIndex:-1},j>re?(L.sortIndex=j,t(c,L),n(u)===null&&L===n(c)&&(w?(f(b),b=-1):w=!0,Fe(k,j-re))):(L.sortIndex=T,t(u,L),y||C||(y=!0,Pt(z))),L},e.unstable_shouldYield=H,e.unstable_wrapCallback=function(L){var F=m;return function(){var j=m;m=F;try{return L.apply(this,arguments)}finally{m=j}}}})(fc);dc.exports=fc;/**
 * @license React
 * react-dom.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */var pc=x.exports,tt=dc.exports;function R(e){for(var t="https://reactjs.org/docs/error-decoder.html?invariant="+e,n=1;n<arguments.length;n++)t+="&args[]="+encodeURIComponent(arguments[n]);return"Minified React error #"+e+"; visit "+t+" for the full message or use the non-minified dev environment for full errors and additional helpful warnings."}var hc=new Set,jr={};function En(e,t){Xn(e,t),Xn(e+"Capture",t)}function Xn(e,t){for(jr[e]=t,e=0;e<t.length;e++)hc.add(t[e])}var _t=!(typeof window=="undefined"||typeof window.document=="undefined"||typeof window.document.createElement=="undefined"),Gl=Object.prototype.hasOwnProperty,bf=/^[:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD][:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD\-.0-9\u00B7\u0300-\u036F\u203F-\u2040]*$/,su={},uu={};function _f(e){return Gl.call(uu,e)?!0:Gl.call(su,e)?!1:bf.test(e)?uu[e]=!0:(su[e]=!0,!1)}function Mf(e,t,n,r){if(n!==null&&n.type===0)return!1;switch(typeof t){case"function":case"symbol":return!0;case"boolean":return r?!1:n!==null?!n.acceptsBooleans:(e=e.toLowerCase().slice(0,5),e!=="data-"&&e!=="aria-");default:return!1}}function Of(e,t,n,r){if(t===null||typeof t=="undefined"||Mf(e,t,n,r))return!0;if(r)return!1;if(n!==null)switch(n.type){case 3:return!t;case 4:return t===!1;case 5:return isNaN(t);case 6:return isNaN(t)||1>t}return!1}function He(e,t,n,r,i,o,l){this.acceptsBooleans=t===2||t===3||t===4,this.attributeName=r,this.attributeNamespace=i,this.mustUseProperty=n,this.propertyName=e,this.type=t,this.sanitizeURL=o,this.removeEmptyString=l}var Te={};"children dangerouslySetInnerHTML defaultValue defaultChecked innerHTML suppressContentEditableWarning suppressHydrationWarning style".split(" ").forEach(function(e){Te[e]=new He(e,0,!1,e,null,!1,!1)});[["acceptCharset","accept-charset"],["className","class"],["htmlFor","for"],["httpEquiv","http-equiv"]].forEach(function(e){var t=e[0];Te[t]=new He(t,1,!1,e[1],null,!1,!1)});["contentEditable","draggable","spellCheck","value"].forEach(function(e){Te[e]=new He(e,2,!1,e.toLowerCase(),null,!1,!1)});["autoReverse","externalResourcesRequired","focusable","preserveAlpha"].forEach(function(e){Te[e]=new He(e,2,!1,e,null,!1,!1)});"allowFullScreen async autoFocus autoPlay controls default defer disabled disablePictureInPicture disableRemotePlayback formNoValidate hidden loop noModule noValidate open playsInline readOnly required reversed scoped seamless itemScope".split(" ").forEach(function(e){Te[e]=new He(e,3,!1,e.toLowerCase(),null,!1,!1)});["checked","multiple","muted","selected"].forEach(function(e){Te[e]=new He(e,3,!0,e,null,!1,!1)});["capture","download"].forEach(function(e){Te[e]=new He(e,4,!1,e,null,!1,!1)});["cols","rows","size","span"].forEach(function(e){Te[e]=new He(e,6,!1,e,null,!1,!1)});["rowSpan","start"].forEach(function(e){Te[e]=new He(e,5,!1,e.toLowerCase(),null,!1,!1)});var ts=/[\-:]([a-z])/g;function ns(e){return e[1].toUpperCase()}"accent-height alignment-baseline arabic-form baseline-shift cap-height clip-path clip-rule color-interpolation color-interpolation-filters color-profile color-rendering dominant-baseline enable-background fill-opacity fill-rule flood-color flood-opacity font-family font-size font-size-adjust font-stretch font-style font-variant font-weight glyph-name glyph-orientation-horizontal glyph-orientation-vertical horiz-adv-x horiz-origin-x image-rendering letter-spacing lighting-color marker-end marker-mid marker-start overline-position overline-thickness paint-order panose-1 pointer-events rendering-intent shape-rendering stop-color stop-opacity strikethrough-position strikethrough-thickness stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width text-anchor text-decoration text-rendering underline-position underline-thickness unicode-bidi unicode-range units-per-em v-alphabetic v-hanging v-ideographic v-mathematical vector-effect vert-adv-y vert-origin-x vert-origin-y word-spacing writing-mode xmlns:xlink x-height".split(" ").forEach(function(e){var t=e.replace(ts,ns);Te[t]=new He(t,1,!1,e,null,!1,!1)});"xlink:actuate xlink:arcrole xlink:role xlink:show xlink:title xlink:type".split(" ").forEach(function(e){var t=e.replace(ts,ns);Te[t]=new He(t,1,!1,e,"http://www.w3.org/1999/xlink",!1,!1)});["xml:base","xml:lang","xml:space"].forEach(function(e){var t=e.replace(ts,ns);Te[t]=new He(t,1,!1,e,"http://www.w3.org/XML/1998/namespace",!1,!1)});["tabIndex","crossOrigin"].forEach(function(e){Te[e]=new He(e,1,!1,e.toLowerCase(),null,!1,!1)});Te.xlinkHref=new He("xlinkHref",1,!1,"xlink:href","http://www.w3.org/1999/xlink",!0,!1);["src","href","action","formAction"].forEach(function(e){Te[e]=new He(e,1,!1,e.toLowerCase(),null,!0,!0)});function rs(e,t,n,r){var i=Te.hasOwnProperty(t)?Te[t]:null;(i!==null?i.type!==0:r||!(2<t.length)||t[0]!=="o"&&t[0]!=="O"||t[1]!=="n"&&t[1]!=="N")&&(Of(t,n,i,r)&&(n=null),r||i===null?_f(t)&&(n===null?e.removeAttribute(t):e.setAttribute(t,""+n)):i.mustUseProperty?e[i.propertyName]=n===null?i.type===3?!1:"":n:(t=i.attributeName,r=i.attributeNamespace,n===null?e.removeAttribute(t):(i=i.type,n=i===3||i===4&&n===!0?"":""+n,r?e.setAttributeNS(r,t,n):e.setAttribute(t,n))))}var $t=pc.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED,gi=Symbol.for("react.element"),_n=Symbol.for("react.portal"),Mn=Symbol.for("react.fragment"),is=Symbol.for("react.strict_mode"),Ql=Symbol.for("react.profiler"),mc=Symbol.for("react.provider"),gc=Symbol.for("react.context"),os=Symbol.for("react.forward_ref"),Yl=Symbol.for("react.suspense"),Kl=Symbol.for("react.suspense_list"),ls=Symbol.for("react.memo"),jt=Symbol.for("react.lazy"),vc=Symbol.for("react.offscreen"),cu=Symbol.iterator;function gr(e){return e===null||typeof e!="object"?null:(e=cu&&e[cu]||e["@@iterator"],typeof e=="function"?e:null)}var ce=Object.assign,dl;function Er(e){if(dl===void 0)try{throw Error()}catch(n){var t=n.stack.trim().match(/\n( *(at )?)/);dl=t&&t[1]||""}return`
`+dl+e}var fl=!1;function pl(e,t){if(!e||fl)return"";fl=!0;var n=Error.prepareStackTrace;Error.prepareStackTrace=void 0;try{if(t)if(t=function(){throw Error()},Object.defineProperty(t.prototype,"props",{set:function(){throw Error()}}),typeof Reflect=="object"&&Reflect.construct){try{Reflect.construct(t,[])}catch(c){var r=c}Reflect.construct(e,[],t)}else{try{t.call()}catch(c){r=c}e.call(t.prototype)}else{try{throw Error()}catch(c){r=c}e()}}catch(c){if(c&&r&&typeof c.stack=="string"){for(var i=c.stack.split(`
`),o=r.stack.split(`
`),l=i.length-1,s=o.length-1;1<=l&&0<=s&&i[l]!==o[s];)s--;for(;1<=l&&0<=s;l--,s--)if(i[l]!==o[s]){if(l!==1||s!==1)do if(l--,s--,0>s||i[l]!==o[s]){var u=`
`+i[l].replace(" at new "," at ");return e.displayName&&u.includes("<anonymous>")&&(u=u.replace("<anonymous>",e.displayName)),u}while(1<=l&&0<=s);break}}}finally{fl=!1,Error.prepareStackTrace=n}return(e=e?e.displayName||e.name:"")?Er(e):""}function Af(e){switch(e.tag){case 5:return Er(e.type);case 16:return Er("Lazy");case 13:return Er("Suspense");case 19:return Er("SuspenseList");case 0:case 2:case 15:return e=pl(e.type,!1),e;case 11:return e=pl(e.type.render,!1),e;case 1:return e=pl(e.type,!0),e;default:return""}}function Zl(e){if(e==null)return null;if(typeof e=="function")return e.displayName||e.name||null;if(typeof e=="string")return e;switch(e){case Mn:return"Fragment";case _n:return"Portal";case Ql:return"Profiler";case is:return"StrictMode";case Yl:return"Suspense";case Kl:return"SuspenseList"}if(typeof e=="object")switch(e.$$typeof){case gc:return(e.displayName||"Context")+".Consumer";case mc:return(e._context.displayName||"Context")+".Provider";case os:var t=e.render;return e=e.displayName,e||(e=t.displayName||t.name||"",e=e!==""?"ForwardRef("+e+")":"ForwardRef"),e;case ls:return t=e.displayName||null,t!==null?t:Zl(e.type)||"Memo";case jt:t=e._payload,e=e._init;try{return Zl(e(t))}catch{}}return null}function $f(e){var t=e.type;switch(e.tag){case 24:return"Cache";case 9:return(t.displayName||"Context")+".Consumer";case 10:return(t._context.displayName||"Context")+".Provider";case 18:return"DehydratedFragment";case 11:return e=t.render,e=e.displayName||e.name||"",t.displayName||(e!==""?"ForwardRef("+e+")":"ForwardRef");case 7:return"Fragment";case 5:return t;case 4:return"Portal";case 3:return"Root";case 6:return"Text";case 16:return Zl(t);case 8:return t===is?"StrictMode":"Mode";case 22:return"Offscreen";case 12:return"Profiler";case 21:return"Scope";case 13:return"Suspense";case 19:return"SuspenseList";case 25:return"TracingMarker";case 1:case 0:case 17:case 2:case 14:case 15:if(typeof t=="function")return t.displayName||t.name||null;if(typeof t=="string")return t}return null}function rn(e){switch(typeof e){case"boolean":case"number":case"string":case"undefined":return e;case"object":return e;default:return""}}function yc(e){var t=e.type;return(e=e.nodeName)&&e.toLowerCase()==="input"&&(t==="checkbox"||t==="radio")}function If(e){var t=yc(e)?"checked":"value",n=Object.getOwnPropertyDescriptor(e.constructor.prototype,t),r=""+e[t];if(!e.hasOwnProperty(t)&&typeof n!="undefined"&&typeof n.get=="function"&&typeof n.set=="function"){var i=n.get,o=n.set;return Object.defineProperty(e,t,{configurable:!0,get:function(){return i.call(this)},set:function(l){r=""+l,o.call(this,l)}}),Object.defineProperty(e,t,{enumerable:n.enumerable}),{getValue:function(){return r},setValue:function(l){r=""+l},stopTracking:function(){e._valueTracker=null,delete e[t]}}}}function vi(e){e._valueTracker||(e._valueTracker=If(e))}function wc(e){if(!e)return!1;var t=e._valueTracker;if(!t)return!0;var n=t.getValue(),r="";return e&&(r=yc(e)?e.checked?"true":"false":e.value),e=r,e!==n?(t.setValue(e),!0):!1}function Zi(e){if(e=e||(typeof document!="undefined"?document:void 0),typeof e=="undefined")return null;try{return e.activeElement||e.body}catch{return e.body}}function Xl(e,t){var n=t.checked;return ce({},t,{defaultChecked:void 0,defaultValue:void 0,value:void 0,checked:n!=null?n:e._wrapperState.initialChecked})}function du(e,t){var n=t.defaultValue==null?"":t.defaultValue,r=t.checked!=null?t.checked:t.defaultChecked;n=rn(t.value!=null?t.value:n),e._wrapperState={initialChecked:r,initialValue:n,controlled:t.type==="checkbox"||t.type==="radio"?t.checked!=null:t.value!=null}}function xc(e,t){t=t.checked,t!=null&&rs(e,"checked",t,!1)}function Jl(e,t){xc(e,t);var n=rn(t.value),r=t.type;if(n!=null)r==="number"?(n===0&&e.value===""||e.value!=n)&&(e.value=""+n):e.value!==""+n&&(e.value=""+n);else if(r==="submit"||r==="reset"){e.removeAttribute("value");return}t.hasOwnProperty("value")?ql(e,t.type,n):t.hasOwnProperty("defaultValue")&&ql(e,t.type,rn(t.defaultValue)),t.checked==null&&t.defaultChecked!=null&&(e.defaultChecked=!!t.defaultChecked)}function fu(e,t,n){if(t.hasOwnProperty("value")||t.hasOwnProperty("defaultValue")){var r=t.type;if(!(r!=="submit"&&r!=="reset"||t.value!==void 0&&t.value!==null))return;t=""+e._wrapperState.initialValue,n||t===e.value||(e.value=t),e.defaultValue=t}n=e.name,n!==""&&(e.name=""),e.defaultChecked=!!e._wrapperState.initialChecked,n!==""&&(e.name=n)}function ql(e,t,n){(t!=="number"||Zi(e.ownerDocument)!==e)&&(n==null?e.defaultValue=""+e._wrapperState.initialValue:e.defaultValue!==""+n&&(e.defaultValue=""+n))}var Pr=Array.isArray;function Wn(e,t,n,r){if(e=e.options,t){t={};for(var i=0;i<n.length;i++)t["$"+n[i]]=!0;for(n=0;n<e.length;n++)i=t.hasOwnProperty("$"+e[n].value),e[n].selected!==i&&(e[n].selected=i),i&&r&&(e[n].defaultSelected=!0)}else{for(n=""+rn(n),t=null,i=0;i<e.length;i++){if(e[i].value===n){e[i].selected=!0,r&&(e[i].defaultSelected=!0);return}t!==null||e[i].disabled||(t=e[i])}t!==null&&(t.selected=!0)}}function ea(e,t){if(t.dangerouslySetInnerHTML!=null)throw Error(R(91));return ce({},t,{value:void 0,defaultValue:void 0,children:""+e._wrapperState.initialValue})}function pu(e,t){var n=t.value;if(n==null){if(n=t.children,t=t.defaultValue,n!=null){if(t!=null)throw Error(R(92));if(Pr(n)){if(1<n.length)throw Error(R(93));n=n[0]}t=n}t==null&&(t=""),n=t}e._wrapperState={initialValue:rn(n)}}function Cc(e,t){var n=rn(t.value),r=rn(t.defaultValue);n!=null&&(n=""+n,n!==e.value&&(e.value=n),t.defaultValue==null&&e.defaultValue!==n&&(e.defaultValue=n)),r!=null&&(e.defaultValue=""+r)}function hu(e){var t=e.textContent;t===e._wrapperState.initialValue&&t!==""&&t!==null&&(e.value=t)}function kc(e){switch(e){case"svg":return"http://www.w3.org/2000/svg";case"math":return"http://www.w3.org/1998/Math/MathML";default:return"http://www.w3.org/1999/xhtml"}}function ta(e,t){return e==null||e==="http://www.w3.org/1999/xhtml"?kc(t):e==="http://www.w3.org/2000/svg"&&t==="foreignObject"?"http://www.w3.org/1999/xhtml":e}var yi,Sc=function(e){return typeof MSApp!="undefined"&&MSApp.execUnsafeLocalFunction?function(t,n,r,i){MSApp.execUnsafeLocalFunction(function(){return e(t,n,r,i)})}:e}(function(e,t){if(e.namespaceURI!=="http://www.w3.org/2000/svg"||"innerHTML"in e)e.innerHTML=t;else{for(yi=yi||document.createElement("div"),yi.innerHTML="<svg>"+t.valueOf().toString()+"</svg>",t=yi.firstChild;e.firstChild;)e.removeChild(e.firstChild);for(;t.firstChild;)e.appendChild(t.firstChild)}});function Dr(e,t){if(t){var n=e.firstChild;if(n&&n===e.lastChild&&n.nodeType===3){n.nodeValue=t;return}}e.textContent=t}var Nr={animationIterationCount:!0,aspectRatio:!0,borderImageOutset:!0,borderImageSlice:!0,borderImageWidth:!0,boxFlex:!0,boxFlexGroup:!0,boxOrdinalGroup:!0,columnCount:!0,columns:!0,flex:!0,flexGrow:!0,flexPositive:!0,flexShrink:!0,flexNegative:!0,flexOrder:!0,gridArea:!0,gridRow:!0,gridRowEnd:!0,gridRowSpan:!0,gridRowStart:!0,gridColumn:!0,gridColumnEnd:!0,gridColumnSpan:!0,gridColumnStart:!0,fontWeight:!0,lineClamp:!0,lineHeight:!0,opacity:!0,order:!0,orphans:!0,tabSize:!0,widows:!0,zIndex:!0,zoom:!0,fillOpacity:!0,floodOpacity:!0,stopOpacity:!0,strokeDasharray:!0,strokeDashoffset:!0,strokeMiterlimit:!0,strokeOpacity:!0,strokeWidth:!0},Ff=["Webkit","ms","Moz","O"];Object.keys(Nr).forEach(function(e){Ff.forEach(function(t){t=t+e.charAt(0).toUpperCase()+e.substring(1),Nr[t]=Nr[e]})});function Ec(e,t,n){return t==null||typeof t=="boolean"||t===""?"":n||typeof t!="number"||t===0||Nr.hasOwnProperty(e)&&Nr[e]?(""+t).trim():t+"px"}function Pc(e,t){e=e.style;for(var n in t)if(t.hasOwnProperty(n)){var r=n.indexOf("--")===0,i=Ec(n,t[n],r);n==="float"&&(n="cssFloat"),r?e.setProperty(n,i):e[n]=i}}var jf=ce({menuitem:!0},{area:!0,base:!0,br:!0,col:!0,embed:!0,hr:!0,img:!0,input:!0,keygen:!0,link:!0,meta:!0,param:!0,source:!0,track:!0,wbr:!0});function na(e,t){if(t){if(jf[e]&&(t.children!=null||t.dangerouslySetInnerHTML!=null))throw Error(R(137,e));if(t.dangerouslySetInnerHTML!=null){if(t.children!=null)throw Error(R(60));if(typeof t.dangerouslySetInnerHTML!="object"||!("__html"in t.dangerouslySetInnerHTML))throw Error(R(61))}if(t.style!=null&&typeof t.style!="object")throw Error(R(62))}}function ra(e,t){if(e.indexOf("-")===-1)return typeof t.is=="string";switch(e){case"annotation-xml":case"color-profile":case"font-face":case"font-face-src":case"font-face-uri":case"font-face-format":case"font-face-name":case"missing-glyph":return!1;default:return!0}}var ia=null;function as(e){return e=e.target||e.srcElement||window,e.correspondingUseElement&&(e=e.correspondingUseElement),e.nodeType===3?e.parentNode:e}var oa=null,Gn=null,Qn=null;function mu(e){if(e=si(e)){if(typeof oa!="function")throw Error(R(280));var t=e.stateNode;t&&(t=To(t),oa(e.stateNode,e.type,t))}}function zc(e){Gn?Qn?Qn.push(e):Qn=[e]:Gn=e}function Rc(){if(Gn){var e=Gn,t=Qn;if(Qn=Gn=null,mu(e),t)for(e=0;e<t.length;e++)mu(t[e])}}function Lc(e,t){return e(t)}function Nc(){}var hl=!1;function Tc(e,t,n){if(hl)return e(t,n);hl=!0;try{return Lc(e,t,n)}finally{hl=!1,(Gn!==null||Qn!==null)&&(Nc(),Rc())}}function Br(e,t){var n=e.stateNode;if(n===null)return null;var r=To(n);if(r===null)return null;n=r[t];e:switch(t){case"onClick":case"onClickCapture":case"onDoubleClick":case"onDoubleClickCapture":case"onMouseDown":case"onMouseDownCapture":case"onMouseMove":case"onMouseMoveCapture":case"onMouseUp":case"onMouseUpCapture":case"onMouseEnter":(r=!r.disabled)||(e=e.type,r=!(e==="button"||e==="input"||e==="select"||e==="textarea")),e=!r;break e;default:e=!1}if(e)return null;if(n&&typeof n!="function")throw Error(R(231,t,typeof n));return n}var la=!1;if(_t)try{var vr={};Object.defineProperty(vr,"passive",{get:function(){la=!0}}),window.addEventListener("test",vr,vr),window.removeEventListener("test",vr,vr)}catch{la=!1}function Df(e,t,n,r,i,o,l,s,u){var c=Array.prototype.slice.call(arguments,3);try{t.apply(n,c)}catch(p){this.onError(p)}}var Tr=!1,Xi=null,Ji=!1,aa=null,Bf={onError:function(e){Tr=!0,Xi=e}};function Hf(e,t,n,r,i,o,l,s,u){Tr=!1,Xi=null,Df.apply(Bf,arguments)}function Uf(e,t,n,r,i,o,l,s,u){if(Hf.apply(this,arguments),Tr){if(Tr){var c=Xi;Tr=!1,Xi=null}else throw Error(R(198));Ji||(Ji=!0,aa=c)}}function Pn(e){var t=e,n=e;if(e.alternate)for(;t.return;)t=t.return;else{e=t;do t=e,(t.flags&4098)!==0&&(n=t.return),e=t.return;while(e)}return t.tag===3?n:null}function bc(e){if(e.tag===13){var t=e.memoizedState;if(t===null&&(e=e.alternate,e!==null&&(t=e.memoizedState)),t!==null)return t.dehydrated}return null}function gu(e){if(Pn(e)!==e)throw Error(R(188))}function Vf(e){var t=e.alternate;if(!t){if(t=Pn(e),t===null)throw Error(R(188));return t!==e?null:e}for(var n=e,r=t;;){var i=n.return;if(i===null)break;var o=i.alternate;if(o===null){if(r=i.return,r!==null){n=r;continue}break}if(i.child===o.child){for(o=i.child;o;){if(o===n)return gu(i),e;if(o===r)return gu(i),t;o=o.sibling}throw Error(R(188))}if(n.return!==r.return)n=i,r=o;else{for(var l=!1,s=i.child;s;){if(s===n){l=!0,n=i,r=o;break}if(s===r){l=!0,r=i,n=o;break}s=s.sibling}if(!l){for(s=o.child;s;){if(s===n){l=!0,n=o,r=i;break}if(s===r){l=!0,r=o,n=i;break}s=s.sibling}if(!l)throw Error(R(189))}}if(n.alternate!==r)throw Error(R(190))}if(n.tag!==3)throw Error(R(188));return n.stateNode.current===n?e:t}function _c(e){return e=Vf(e),e!==null?Mc(e):null}function Mc(e){if(e.tag===5||e.tag===6)return e;for(e=e.child;e!==null;){var t=Mc(e);if(t!==null)return t;e=e.sibling}return null}var Oc=tt.unstable_scheduleCallback,vu=tt.unstable_cancelCallback,Wf=tt.unstable_shouldYield,Gf=tt.unstable_requestPaint,he=tt.unstable_now,Qf=tt.unstable_getCurrentPriorityLevel,ss=tt.unstable_ImmediatePriority,Ac=tt.unstable_UserBlockingPriority,qi=tt.unstable_NormalPriority,Yf=tt.unstable_LowPriority,$c=tt.unstable_IdlePriority,zo=null,St=null;function Kf(e){if(St&&typeof St.onCommitFiberRoot=="function")try{St.onCommitFiberRoot(zo,e,void 0,(e.current.flags&128)===128)}catch{}}var vt=Math.clz32?Math.clz32:Jf,Zf=Math.log,Xf=Math.LN2;function Jf(e){return e>>>=0,e===0?32:31-(Zf(e)/Xf|0)|0}var wi=64,xi=4194304;function zr(e){switch(e&-e){case 1:return 1;case 2:return 2;case 4:return 4;case 8:return 8;case 16:return 16;case 32:return 32;case 64:case 128:case 256:case 512:case 1024:case 2048:case 4096:case 8192:case 16384:case 32768:case 65536:case 131072:case 262144:case 524288:case 1048576:case 2097152:return e&4194240;case 4194304:case 8388608:case 16777216:case 33554432:case 67108864:return e&130023424;case 134217728:return 134217728;case 268435456:return 268435456;case 536870912:return 536870912;case 1073741824:return 1073741824;default:return e}}function eo(e,t){var n=e.pendingLanes;if(n===0)return 0;var r=0,i=e.suspendedLanes,o=e.pingedLanes,l=n&268435455;if(l!==0){var s=l&~i;s!==0?r=zr(s):(o&=l,o!==0&&(r=zr(o)))}else l=n&~i,l!==0?r=zr(l):o!==0&&(r=zr(o));if(r===0)return 0;if(t!==0&&t!==r&&(t&i)===0&&(i=r&-r,o=t&-t,i>=o||i===16&&(o&4194240)!==0))return t;if((r&4)!==0&&(r|=n&16),t=e.entangledLanes,t!==0)for(e=e.entanglements,t&=r;0<t;)n=31-vt(t),i=1<<n,r|=e[n],t&=~i;return r}function qf(e,t){switch(e){case 1:case 2:case 4:return t+250;case 8:case 16:case 32:case 64:case 128:case 256:case 512:case 1024:case 2048:case 4096:case 8192:case 16384:case 32768:case 65536:case 131072:case 262144:case 524288:case 1048576:case 2097152:return t+5e3;case 4194304:case 8388608:case 16777216:case 33554432:case 67108864:return-1;case 134217728:case 268435456:case 536870912:case 1073741824:return-1;default:return-1}}function e5(e,t){for(var n=e.suspendedLanes,r=e.pingedLanes,i=e.expirationTimes,o=e.pendingLanes;0<o;){var l=31-vt(o),s=1<<l,u=i[l];u===-1?((s&n)===0||(s&r)!==0)&&(i[l]=qf(s,t)):u<=t&&(e.expiredLanes|=s),o&=~s}}function sa(e){return e=e.pendingLanes&-1073741825,e!==0?e:e&1073741824?1073741824:0}function Ic(){var e=wi;return wi<<=1,(wi&4194240)===0&&(wi=64),e}function ml(e){for(var t=[],n=0;31>n;n++)t.push(e);return t}function li(e,t,n){e.pendingLanes|=t,t!==536870912&&(e.suspendedLanes=0,e.pingedLanes=0),e=e.eventTimes,t=31-vt(t),e[t]=n}function t5(e,t){var n=e.pendingLanes&~t;e.pendingLanes=t,e.suspendedLanes=0,e.pingedLanes=0,e.expiredLanes&=t,e.mutableReadLanes&=t,e.entangledLanes&=t,t=e.entanglements;var r=e.eventTimes;for(e=e.expirationTimes;0<n;){var i=31-vt(n),o=1<<i;t[i]=0,r[i]=-1,e[i]=-1,n&=~o}}function us(e,t){var n=e.entangledLanes|=t;for(e=e.entanglements;n;){var r=31-vt(n),i=1<<r;i&t|e[r]&t&&(e[r]|=t),n&=~i}}var ee=0;function Fc(e){return e&=-e,1<e?4<e?(e&268435455)!==0?16:536870912:4:1}var jc,cs,Dc,Bc,Hc,ua=!1,Ci=[],Gt=null,Qt=null,Yt=null,Hr=new Map,Ur=new Map,Bt=[],n5="mousedown mouseup touchcancel touchend touchstart auxclick dblclick pointercancel pointerdown pointerup dragend dragstart drop compositionend compositionstart keydown keypress keyup input textInput copy cut paste click change contextmenu reset submit".split(" ");function yu(e,t){switch(e){case"focusin":case"focusout":Gt=null;break;case"dragenter":case"dragleave":Qt=null;break;case"mouseover":case"mouseout":Yt=null;break;case"pointerover":case"pointerout":Hr.delete(t.pointerId);break;case"gotpointercapture":case"lostpointercapture":Ur.delete(t.pointerId)}}function yr(e,t,n,r,i,o){return e===null||e.nativeEvent!==o?(e={blockedOn:t,domEventName:n,eventSystemFlags:r,nativeEvent:o,targetContainers:[i]},t!==null&&(t=si(t),t!==null&&cs(t)),e):(e.eventSystemFlags|=r,t=e.targetContainers,i!==null&&t.indexOf(i)===-1&&t.push(i),e)}function r5(e,t,n,r,i){switch(t){case"focusin":return Gt=yr(Gt,e,t,n,r,i),!0;case"dragenter":return Qt=yr(Qt,e,t,n,r,i),!0;case"mouseover":return Yt=yr(Yt,e,t,n,r,i),!0;case"pointerover":var o=i.pointerId;return Hr.set(o,yr(Hr.get(o)||null,e,t,n,r,i)),!0;case"gotpointercapture":return o=i.pointerId,Ur.set(o,yr(Ur.get(o)||null,e,t,n,r,i)),!0}return!1}function Uc(e){var t=fn(e.target);if(t!==null){var n=Pn(t);if(n!==null){if(t=n.tag,t===13){if(t=bc(n),t!==null){e.blockedOn=t,Hc(e.priority,function(){Dc(n)});return}}else if(t===3&&n.stateNode.current.memoizedState.isDehydrated){e.blockedOn=n.tag===3?n.stateNode.containerInfo:null;return}}}e.blockedOn=null}function $i(e){if(e.blockedOn!==null)return!1;for(var t=e.targetContainers;0<t.length;){var n=ca(e.domEventName,e.eventSystemFlags,t[0],e.nativeEvent);if(n===null){n=e.nativeEvent;var r=new n.constructor(n.type,n);ia=r,n.target.dispatchEvent(r),ia=null}else return t=si(n),t!==null&&cs(t),e.blockedOn=n,!1;t.shift()}return!0}function wu(e,t,n){$i(e)&&n.delete(t)}function i5(){ua=!1,Gt!==null&&$i(Gt)&&(Gt=null),Qt!==null&&$i(Qt)&&(Qt=null),Yt!==null&&$i(Yt)&&(Yt=null),Hr.forEach(wu),Ur.forEach(wu)}function wr(e,t){e.blockedOn===t&&(e.blockedOn=null,ua||(ua=!0,tt.unstable_scheduleCallback(tt.unstable_NormalPriority,i5)))}function Vr(e){function t(i){return wr(i,e)}if(0<Ci.length){wr(Ci[0],e);for(var n=1;n<Ci.length;n++){var r=Ci[n];r.blockedOn===e&&(r.blockedOn=null)}}for(Gt!==null&&wr(Gt,e),Qt!==null&&wr(Qt,e),Yt!==null&&wr(Yt,e),Hr.forEach(t),Ur.forEach(t),n=0;n<Bt.length;n++)r=Bt[n],r.blockedOn===e&&(r.blockedOn=null);for(;0<Bt.length&&(n=Bt[0],n.blockedOn===null);)Uc(n),n.blockedOn===null&&Bt.shift()}var Yn=$t.ReactCurrentBatchConfig,to=!0;function o5(e,t,n,r){var i=ee,o=Yn.transition;Yn.transition=null;try{ee=1,ds(e,t,n,r)}finally{ee=i,Yn.transition=o}}function l5(e,t,n,r){var i=ee,o=Yn.transition;Yn.transition=null;try{ee=4,ds(e,t,n,r)}finally{ee=i,Yn.transition=o}}function ds(e,t,n,r){if(to){var i=ca(e,t,n,r);if(i===null)Pl(e,t,r,no,n),yu(e,r);else if(r5(i,e,t,n,r))r.stopPropagation();else if(yu(e,r),t&4&&-1<n5.indexOf(e)){for(;i!==null;){var o=si(i);if(o!==null&&jc(o),o=ca(e,t,n,r),o===null&&Pl(e,t,r,no,n),o===i)break;i=o}i!==null&&r.stopPropagation()}else Pl(e,t,r,null,n)}}var no=null;function ca(e,t,n,r){if(no=null,e=as(r),e=fn(e),e!==null)if(t=Pn(e),t===null)e=null;else if(n=t.tag,n===13){if(e=bc(t),e!==null)return e;e=null}else if(n===3){if(t.stateNode.current.memoizedState.isDehydrated)return t.tag===3?t.stateNode.containerInfo:null;e=null}else t!==e&&(e=null);return no=e,null}function Vc(e){switch(e){case"cancel":case"click":case"close":case"contextmenu":case"copy":case"cut":case"auxclick":case"dblclick":case"dragend":case"dragstart":case"drop":case"focusin":case"focusout":case"input":case"invalid":case"keydown":case"keypress":case"keyup":case"mousedown":case"mouseup":case"paste":case"pause":case"play":case"pointercancel":case"pointerdown":case"pointerup":case"ratechange":case"reset":case"resize":case"seeked":case"submit":case"touchcancel":case"touchend":case"touchstart":case"volumechange":case"change":case"selectionchange":case"textInput":case"compositionstart":case"compositionend":case"compositionupdate":case"beforeblur":case"afterblur":case"beforeinput":case"blur":case"fullscreenchange":case"focus":case"hashchange":case"popstate":case"select":case"selectstart":return 1;case"drag":case"dragenter":case"dragexit":case"dragleave":case"dragover":case"mousemove":case"mouseout":case"mouseover":case"pointermove":case"pointerout":case"pointerover":case"scroll":case"toggle":case"touchmove":case"wheel":case"mouseenter":case"mouseleave":case"pointerenter":case"pointerleave":return 4;case"message":switch(Qf()){case ss:return 1;case Ac:return 4;case qi:case Yf:return 16;case $c:return 536870912;default:return 16}default:return 16}}var Ut=null,fs=null,Ii=null;function Wc(){if(Ii)return Ii;var e,t=fs,n=t.length,r,i="value"in Ut?Ut.value:Ut.textContent,o=i.length;for(e=0;e<n&&t[e]===i[e];e++);var l=n-e;for(r=1;r<=l&&t[n-r]===i[o-r];r++);return Ii=i.slice(e,1<r?1-r:void 0)}function Fi(e){var t=e.keyCode;return"charCode"in e?(e=e.charCode,e===0&&t===13&&(e=13)):e=t,e===10&&(e=13),32<=e||e===13?e:0}function ki(){return!0}function xu(){return!1}function rt(e){function t(n,r,i,o,l){this._reactName=n,this._targetInst=i,this.type=r,this.nativeEvent=o,this.target=l,this.currentTarget=null;for(var s in e)e.hasOwnProperty(s)&&(n=e[s],this[s]=n?n(o):o[s]);return this.isDefaultPrevented=(o.defaultPrevented!=null?o.defaultPrevented:o.returnValue===!1)?ki:xu,this.isPropagationStopped=xu,this}return ce(t.prototype,{preventDefault:function(){this.defaultPrevented=!0;var n=this.nativeEvent;n&&(n.preventDefault?n.preventDefault():typeof n.returnValue!="unknown"&&(n.returnValue=!1),this.isDefaultPrevented=ki)},stopPropagation:function(){var n=this.nativeEvent;n&&(n.stopPropagation?n.stopPropagation():typeof n.cancelBubble!="unknown"&&(n.cancelBubble=!0),this.isPropagationStopped=ki)},persist:function(){},isPersistent:ki}),t}var sr={eventPhase:0,bubbles:0,cancelable:0,timeStamp:function(e){return e.timeStamp||Date.now()},defaultPrevented:0,isTrusted:0},ps=rt(sr),ai=ce({},sr,{view:0,detail:0}),a5=rt(ai),gl,vl,xr,Ro=ce({},ai,{screenX:0,screenY:0,clientX:0,clientY:0,pageX:0,pageY:0,ctrlKey:0,shiftKey:0,altKey:0,metaKey:0,getModifierState:hs,button:0,buttons:0,relatedTarget:function(e){return e.relatedTarget===void 0?e.fromElement===e.srcElement?e.toElement:e.fromElement:e.relatedTarget},movementX:function(e){return"movementX"in e?e.movementX:(e!==xr&&(xr&&e.type==="mousemove"?(gl=e.screenX-xr.screenX,vl=e.screenY-xr.screenY):vl=gl=0,xr=e),gl)},movementY:function(e){return"movementY"in e?e.movementY:vl}}),Cu=rt(Ro),s5=ce({},Ro,{dataTransfer:0}),u5=rt(s5),c5=ce({},ai,{relatedTarget:0}),yl=rt(c5),d5=ce({},sr,{animationName:0,elapsedTime:0,pseudoElement:0}),f5=rt(d5),p5=ce({},sr,{clipboardData:function(e){return"clipboardData"in e?e.clipboardData:window.clipboardData}}),h5=rt(p5),m5=ce({},sr,{data:0}),ku=rt(m5),g5={Esc:"Escape",Spacebar:" ",Left:"ArrowLeft",Up:"ArrowUp",Right:"ArrowRight",Down:"ArrowDown",Del:"Delete",Win:"OS",Menu:"ContextMenu",Apps:"ContextMenu",Scroll:"ScrollLock",MozPrintableKey:"Unidentified"},v5={8:"Backspace",9:"Tab",12:"Clear",13:"Enter",16:"Shift",17:"Control",18:"Alt",19:"Pause",20:"CapsLock",27:"Escape",32:" ",33:"PageUp",34:"PageDown",35:"End",36:"Home",37:"ArrowLeft",38:"ArrowUp",39:"ArrowRight",40:"ArrowDown",45:"Insert",46:"Delete",112:"F1",113:"F2",114:"F3",115:"F4",116:"F5",117:"F6",118:"F7",119:"F8",120:"F9",121:"F10",122:"F11",123:"F12",144:"NumLock",145:"ScrollLock",224:"Meta"},y5={Alt:"altKey",Control:"ctrlKey",Meta:"metaKey",Shift:"shiftKey"};function w5(e){var t=this.nativeEvent;return t.getModifierState?t.getModifierState(e):(e=y5[e])?!!t[e]:!1}function hs(){return w5}var x5=ce({},ai,{key:function(e){if(e.key){var t=g5[e.key]||e.key;if(t!=="Unidentified")return t}return e.type==="keypress"?(e=Fi(e),e===13?"Enter":String.fromCharCode(e)):e.type==="keydown"||e.type==="keyup"?v5[e.keyCode]||"Unidentified":""},code:0,location:0,ctrlKey:0,shiftKey:0,altKey:0,metaKey:0,repeat:0,locale:0,getModifierState:hs,charCode:function(e){return e.type==="keypress"?Fi(e):0},keyCode:function(e){return e.type==="keydown"||e.type==="keyup"?e.keyCode:0},which:function(e){return e.type==="keypress"?Fi(e):e.type==="keydown"||e.type==="keyup"?e.keyCode:0}}),C5=rt(x5),k5=ce({},Ro,{pointerId:0,width:0,height:0,pressure:0,tangentialPressure:0,tiltX:0,tiltY:0,twist:0,pointerType:0,isPrimary:0}),Su=rt(k5),S5=ce({},ai,{touches:0,targetTouches:0,changedTouches:0,altKey:0,metaKey:0,ctrlKey:0,shiftKey:0,getModifierState:hs}),E5=rt(S5),P5=ce({},sr,{propertyName:0,elapsedTime:0,pseudoElement:0}),z5=rt(P5),R5=ce({},Ro,{deltaX:function(e){return"deltaX"in e?e.deltaX:"wheelDeltaX"in e?-e.wheelDeltaX:0},deltaY:function(e){return"deltaY"in e?e.deltaY:"wheelDeltaY"in e?-e.wheelDeltaY:"wheelDelta"in e?-e.wheelDelta:0},deltaZ:0,deltaMode:0}),L5=rt(R5),N5=[9,13,27,32],ms=_t&&"CompositionEvent"in window,br=null;_t&&"documentMode"in document&&(br=document.documentMode);var T5=_t&&"TextEvent"in window&&!br,Gc=_t&&(!ms||br&&8<br&&11>=br),Eu=String.fromCharCode(32),Pu=!1;function Qc(e,t){switch(e){case"keyup":return N5.indexOf(t.keyCode)!==-1;case"keydown":return t.keyCode!==229;case"keypress":case"mousedown":case"focusout":return!0;default:return!1}}function Yc(e){return e=e.detail,typeof e=="object"&&"data"in e?e.data:null}var On=!1;function b5(e,t){switch(e){case"compositionend":return Yc(t);case"keypress":return t.which!==32?null:(Pu=!0,Eu);case"textInput":return e=t.data,e===Eu&&Pu?null:e;default:return null}}function _5(e,t){if(On)return e==="compositionend"||!ms&&Qc(e,t)?(e=Wc(),Ii=fs=Ut=null,On=!1,e):null;switch(e){case"paste":return null;case"keypress":if(!(t.ctrlKey||t.altKey||t.metaKey)||t.ctrlKey&&t.altKey){if(t.char&&1<t.char.length)return t.char;if(t.which)return String.fromCharCode(t.which)}return null;case"compositionend":return Gc&&t.locale!=="ko"?null:t.data;default:return null}}var M5={color:!0,date:!0,datetime:!0,"datetime-local":!0,email:!0,month:!0,number:!0,password:!0,range:!0,search:!0,tel:!0,text:!0,time:!0,url:!0,week:!0};function zu(e){var t=e&&e.nodeName&&e.nodeName.toLowerCase();return t==="input"?!!M5[e.type]:t==="textarea"}function Kc(e,t,n,r){zc(r),t=ro(t,"onChange"),0<t.length&&(n=new ps("onChange","change",null,n,r),e.push({event:n,listeners:t}))}var _r=null,Wr=null;function O5(e){l0(e,0)}function Lo(e){var t=In(e);if(wc(t))return e}function A5(e,t){if(e==="change")return t}var Zc=!1;if(_t){var wl;if(_t){var xl="oninput"in document;if(!xl){var Ru=document.createElement("div");Ru.setAttribute("oninput","return;"),xl=typeof Ru.oninput=="function"}wl=xl}else wl=!1;Zc=wl&&(!document.documentMode||9<document.documentMode)}function Lu(){_r&&(_r.detachEvent("onpropertychange",Xc),Wr=_r=null)}function Xc(e){if(e.propertyName==="value"&&Lo(Wr)){var t=[];Kc(t,Wr,e,as(e)),Tc(O5,t)}}function $5(e,t,n){e==="focusin"?(Lu(),_r=t,Wr=n,_r.attachEvent("onpropertychange",Xc)):e==="focusout"&&Lu()}function I5(e){if(e==="selectionchange"||e==="keyup"||e==="keydown")return Lo(Wr)}function F5(e,t){if(e==="click")return Lo(t)}function j5(e,t){if(e==="input"||e==="change")return Lo(t)}function D5(e,t){return e===t&&(e!==0||1/e===1/t)||e!==e&&t!==t}var wt=typeof Object.is=="function"?Object.is:D5;function Gr(e,t){if(wt(e,t))return!0;if(typeof e!="object"||e===null||typeof t!="object"||t===null)return!1;var n=Object.keys(e),r=Object.keys(t);if(n.length!==r.length)return!1;for(r=0;r<n.length;r++){var i=n[r];if(!Gl.call(t,i)||!wt(e[i],t[i]))return!1}return!0}function Nu(e){for(;e&&e.firstChild;)e=e.firstChild;return e}function Tu(e,t){var n=Nu(e);e=0;for(var r;n;){if(n.nodeType===3){if(r=e+n.textContent.length,e<=t&&r>=t)return{node:n,offset:t-e};e=r}e:{for(;n;){if(n.nextSibling){n=n.nextSibling;break e}n=n.parentNode}n=void 0}n=Nu(n)}}function Jc(e,t){return e&&t?e===t?!0:e&&e.nodeType===3?!1:t&&t.nodeType===3?Jc(e,t.parentNode):"contains"in e?e.contains(t):e.compareDocumentPosition?!!(e.compareDocumentPosition(t)&16):!1:!1}function qc(){for(var e=window,t=Zi();t instanceof e.HTMLIFrameElement;){try{var n=typeof t.contentWindow.location.href=="string"}catch{n=!1}if(n)e=t.contentWindow;else break;t=Zi(e.document)}return t}function gs(e){var t=e&&e.nodeName&&e.nodeName.toLowerCase();return t&&(t==="input"&&(e.type==="text"||e.type==="search"||e.type==="tel"||e.type==="url"||e.type==="password")||t==="textarea"||e.contentEditable==="true")}function B5(e){var t=qc(),n=e.focusedElem,r=e.selectionRange;if(t!==n&&n&&n.ownerDocument&&Jc(n.ownerDocument.documentElement,n)){if(r!==null&&gs(n)){if(t=r.start,e=r.end,e===void 0&&(e=t),"selectionStart"in n)n.selectionStart=t,n.selectionEnd=Math.min(e,n.value.length);else if(e=(t=n.ownerDocument||document)&&t.defaultView||window,e.getSelection){e=e.getSelection();var i=n.textContent.length,o=Math.min(r.start,i);r=r.end===void 0?o:Math.min(r.end,i),!e.extend&&o>r&&(i=r,r=o,o=i),i=Tu(n,o);var l=Tu(n,r);i&&l&&(e.rangeCount!==1||e.anchorNode!==i.node||e.anchorOffset!==i.offset||e.focusNode!==l.node||e.focusOffset!==l.offset)&&(t=t.createRange(),t.setStart(i.node,i.offset),e.removeAllRanges(),o>r?(e.addRange(t),e.extend(l.node,l.offset)):(t.setEnd(l.node,l.offset),e.addRange(t)))}}for(t=[],e=n;e=e.parentNode;)e.nodeType===1&&t.push({element:e,left:e.scrollLeft,top:e.scrollTop});for(typeof n.focus=="function"&&n.focus(),n=0;n<t.length;n++)e=t[n],e.element.scrollLeft=e.left,e.element.scrollTop=e.top}}var H5=_t&&"documentMode"in document&&11>=document.documentMode,An=null,da=null,Mr=null,fa=!1;function bu(e,t,n){var r=n.window===n?n.document:n.nodeType===9?n:n.ownerDocument;fa||An==null||An!==Zi(r)||(r=An,"selectionStart"in r&&gs(r)?r={start:r.selectionStart,end:r.selectionEnd}:(r=(r.ownerDocument&&r.ownerDocument.defaultView||window).getSelection(),r={anchorNode:r.anchorNode,anchorOffset:r.anchorOffset,focusNode:r.focusNode,focusOffset:r.focusOffset}),Mr&&Gr(Mr,r)||(Mr=r,r=ro(da,"onSelect"),0<r.length&&(t=new ps("onSelect","select",null,t,n),e.push({event:t,listeners:r}),t.target=An)))}function Si(e,t){var n={};return n[e.toLowerCase()]=t.toLowerCase(),n["Webkit"+e]="webkit"+t,n["Moz"+e]="moz"+t,n}var $n={animationend:Si("Animation","AnimationEnd"),animationiteration:Si("Animation","AnimationIteration"),animationstart:Si("Animation","AnimationStart"),transitionend:Si("Transition","TransitionEnd")},Cl={},e0={};_t&&(e0=document.createElement("div").style,"AnimationEvent"in window||(delete $n.animationend.animation,delete $n.animationiteration.animation,delete $n.animationstart.animation),"TransitionEvent"in window||delete $n.transitionend.transition);function No(e){if(Cl[e])return Cl[e];if(!$n[e])return e;var t=$n[e],n;for(n in t)if(t.hasOwnProperty(n)&&n in e0)return Cl[e]=t[n];return e}var t0=No("animationend"),n0=No("animationiteration"),r0=No("animationstart"),i0=No("transitionend"),o0=new Map,_u="abort auxClick cancel canPlay canPlayThrough click close contextMenu copy cut drag dragEnd dragEnter dragExit dragLeave dragOver dragStart drop durationChange emptied encrypted ended error gotPointerCapture input invalid keyDown keyPress keyUp load loadedData loadedMetadata loadStart lostPointerCapture mouseDown mouseMove mouseOut mouseOver mouseUp paste pause play playing pointerCancel pointerDown pointerMove pointerOut pointerOver pointerUp progress rateChange reset resize seeked seeking stalled submit suspend timeUpdate touchCancel touchEnd touchStart volumeChange scroll toggle touchMove waiting wheel".split(" ");function ln(e,t){o0.set(e,t),En(t,[e])}for(var kl=0;kl<_u.length;kl++){var Sl=_u[kl],U5=Sl.toLowerCase(),V5=Sl[0].toUpperCase()+Sl.slice(1);ln(U5,"on"+V5)}ln(t0,"onAnimationEnd");ln(n0,"onAnimationIteration");ln(r0,"onAnimationStart");ln("dblclick","onDoubleClick");ln("focusin","onFocus");ln("focusout","onBlur");ln(i0,"onTransitionEnd");Xn("onMouseEnter",["mouseout","mouseover"]);Xn("onMouseLeave",["mouseout","mouseover"]);Xn("onPointerEnter",["pointerout","pointerover"]);Xn("onPointerLeave",["pointerout","pointerover"]);En("onChange","change click focusin focusout input keydown keyup selectionchange".split(" "));En("onSelect","focusout contextmenu dragend focusin keydown keyup mousedown mouseup selectionchange".split(" "));En("onBeforeInput",["compositionend","keypress","textInput","paste"]);En("onCompositionEnd","compositionend focusout keydown keypress keyup mousedown".split(" "));En("onCompositionStart","compositionstart focusout keydown keypress keyup mousedown".split(" "));En("onCompositionUpdate","compositionupdate focusout keydown keypress keyup mousedown".split(" "));var Rr="abort canplay canplaythrough durationchange emptied encrypted ended error loadeddata loadedmetadata loadstart pause play playing progress ratechange resize seeked seeking stalled suspend timeupdate volumechange waiting".split(" "),W5=new Set("cancel close invalid load scroll toggle".split(" ").concat(Rr));function Mu(e,t,n){var r=e.type||"unknown-event";e.currentTarget=n,Uf(r,t,void 0,e),e.currentTarget=null}function l0(e,t){t=(t&4)!==0;for(var n=0;n<e.length;n++){var r=e[n],i=r.event;r=r.listeners;e:{var o=void 0;if(t)for(var l=r.length-1;0<=l;l--){var s=r[l],u=s.instance,c=s.currentTarget;if(s=s.listener,u!==o&&i.isPropagationStopped())break e;Mu(i,s,c),o=u}else for(l=0;l<r.length;l++){if(s=r[l],u=s.instance,c=s.currentTarget,s=s.listener,u!==o&&i.isPropagationStopped())break e;Mu(i,s,c),o=u}}}if(Ji)throw e=aa,Ji=!1,aa=null,e}function oe(e,t){var n=t[va];n===void 0&&(n=t[va]=new Set);var r=e+"__bubble";n.has(r)||(a0(t,e,2,!1),n.add(r))}function El(e,t,n){var r=0;t&&(r|=4),a0(n,e,r,t)}var Ei="_reactListening"+Math.random().toString(36).slice(2);function Qr(e){if(!e[Ei]){e[Ei]=!0,hc.forEach(function(n){n!=="selectionchange"&&(W5.has(n)||El(n,!1,e),El(n,!0,e))});var t=e.nodeType===9?e:e.ownerDocument;t===null||t[Ei]||(t[Ei]=!0,El("selectionchange",!1,t))}}function a0(e,t,n,r){switch(Vc(t)){case 1:var i=o5;break;case 4:i=l5;break;default:i=ds}n=i.bind(null,t,n,e),i=void 0,!la||t!=="touchstart"&&t!=="touchmove"&&t!=="wheel"||(i=!0),r?i!==void 0?e.addEventListener(t,n,{capture:!0,passive:i}):e.addEventListener(t,n,!0):i!==void 0?e.addEventListener(t,n,{passive:i}):e.addEventListener(t,n,!1)}function Pl(e,t,n,r,i){var o=r;if((t&1)===0&&(t&2)===0&&r!==null)e:for(;;){if(r===null)return;var l=r.tag;if(l===3||l===4){var s=r.stateNode.containerInfo;if(s===i||s.nodeType===8&&s.parentNode===i)break;if(l===4)for(l=r.return;l!==null;){var u=l.tag;if((u===3||u===4)&&(u=l.stateNode.containerInfo,u===i||u.nodeType===8&&u.parentNode===i))return;l=l.return}for(;s!==null;){if(l=fn(s),l===null)return;if(u=l.tag,u===5||u===6){r=o=l;continue e}s=s.parentNode}}r=r.return}Tc(function(){var c=o,p=as(n),g=[];e:{var m=o0.get(e);if(m!==void 0){var C=ps,y=e;switch(e){case"keypress":if(Fi(n)===0)break e;case"keydown":case"keyup":C=C5;break;case"focusin":y="focus",C=yl;break;case"focusout":y="blur",C=yl;break;case"beforeblur":case"afterblur":C=yl;break;case"click":if(n.button===2)break e;case"auxclick":case"dblclick":case"mousedown":case"mousemove":case"mouseup":case"mouseout":case"mouseover":case"contextmenu":C=Cu;break;case"drag":case"dragend":case"dragenter":case"dragexit":case"dragleave":case"dragover":case"dragstart":case"drop":C=u5;break;case"touchcancel":case"touchend":case"touchmove":case"touchstart":C=E5;break;case t0:case n0:case r0:C=f5;break;case i0:C=z5;break;case"scroll":C=a5;break;case"wheel":C=L5;break;case"copy":case"cut":case"paste":C=h5;break;case"gotpointercapture":case"lostpointercapture":case"pointercancel":case"pointerdown":case"pointermove":case"pointerout":case"pointerover":case"pointerup":C=Su}var w=(t&4)!==0,P=!w&&e==="scroll",f=w?m!==null?m+"Capture":null:m;w=[];for(var d=c,h;d!==null;){h=d;var k=h.stateNode;if(h.tag===5&&k!==null&&(h=k,f!==null&&(k=Br(d,f),k!=null&&w.push(Yr(d,k,h)))),P)break;d=d.return}0<w.length&&(m=new C(m,y,null,n,p),g.push({event:m,listeners:w}))}}if((t&7)===0){e:{if(m=e==="mouseover"||e==="pointerover",C=e==="mouseout"||e==="pointerout",m&&n!==ia&&(y=n.relatedTarget||n.fromElement)&&(fn(y)||y[Mt]))break e;if((C||m)&&(m=p.window===p?p:(m=p.ownerDocument)?m.defaultView||m.parentWindow:window,C?(y=n.relatedTarget||n.toElement,C=c,y=y?fn(y):null,y!==null&&(P=Pn(y),y!==P||y.tag!==5&&y.tag!==6)&&(y=null)):(C=null,y=c),C!==y)){if(w=Cu,k="onMouseLeave",f="onMouseEnter",d="mouse",(e==="pointerout"||e==="pointerover")&&(w=Su,k="onPointerLeave",f="onPointerEnter",d="pointer"),P=C==null?m:In(C),h=y==null?m:In(y),m=new w(k,d+"leave",C,n,p),m.target=P,m.relatedTarget=h,k=null,fn(p)===c&&(w=new w(f,d+"enter",y,n,p),w.target=h,w.relatedTarget=P,k=w),P=k,C&&y)t:{for(w=C,f=y,d=0,h=w;h;h=Nn(h))d++;for(h=0,k=f;k;k=Nn(k))h++;for(;0<d-h;)w=Nn(w),d--;for(;0<h-d;)f=Nn(f),h--;for(;d--;){if(w===f||f!==null&&w===f.alternate)break t;w=Nn(w),f=Nn(f)}w=null}else w=null;C!==null&&Ou(g,m,C,w,!1),y!==null&&P!==null&&Ou(g,P,y,w,!0)}}e:{if(m=c?In(c):window,C=m.nodeName&&m.nodeName.toLowerCase(),C==="select"||C==="input"&&m.type==="file")var z=A5;else if(zu(m))if(Zc)z=j5;else{z=I5;var _=$5}else(C=m.nodeName)&&C.toLowerCase()==="input"&&(m.type==="checkbox"||m.type==="radio")&&(z=F5);if(z&&(z=z(e,c))){Kc(g,z,n,p);break e}_&&_(e,m,c),e==="focusout"&&(_=m._wrapperState)&&_.controlled&&m.type==="number"&&ql(m,"number",m.value)}switch(_=c?In(c):window,e){case"focusin":(zu(_)||_.contentEditable==="true")&&(An=_,da=c,Mr=null);break;case"focusout":Mr=da=An=null;break;case"mousedown":fa=!0;break;case"contextmenu":case"mouseup":case"dragend":fa=!1,bu(g,n,p);break;case"selectionchange":if(H5)break;case"keydown":case"keyup":bu(g,n,p)}var M;if(ms)e:{switch(e){case"compositionstart":var b="onCompositionStart";break e;case"compositionend":b="onCompositionEnd";break e;case"compositionupdate":b="onCompositionUpdate";break e}b=void 0}else On?Qc(e,n)&&(b="onCompositionEnd"):e==="keydown"&&n.keyCode===229&&(b="onCompositionStart");b&&(Gc&&n.locale!=="ko"&&(On||b!=="onCompositionStart"?b==="onCompositionEnd"&&On&&(M=Wc()):(Ut=p,fs="value"in Ut?Ut.value:Ut.textContent,On=!0)),_=ro(c,b),0<_.length&&(b=new ku(b,e,null,n,p),g.push({event:b,listeners:_}),M?b.data=M:(M=Yc(n),M!==null&&(b.data=M)))),(M=T5?b5(e,n):_5(e,n))&&(c=ro(c,"onBeforeInput"),0<c.length&&(p=new ku("onBeforeInput","beforeinput",null,n,p),g.push({event:p,listeners:c}),p.data=M))}l0(g,t)})}function Yr(e,t,n){return{instance:e,listener:t,currentTarget:n}}function ro(e,t){for(var n=t+"Capture",r=[];e!==null;){var i=e,o=i.stateNode;i.tag===5&&o!==null&&(i=o,o=Br(e,n),o!=null&&r.unshift(Yr(e,o,i)),o=Br(e,t),o!=null&&r.push(Yr(e,o,i))),e=e.return}return r}function Nn(e){if(e===null)return null;do e=e.return;while(e&&e.tag!==5);return e||null}function Ou(e,t,n,r,i){for(var o=t._reactName,l=[];n!==null&&n!==r;){var s=n,u=s.alternate,c=s.stateNode;if(u!==null&&u===r)break;s.tag===5&&c!==null&&(s=c,i?(u=Br(n,o),u!=null&&l.unshift(Yr(n,u,s))):i||(u=Br(n,o),u!=null&&l.push(Yr(n,u,s)))),n=n.return}l.length!==0&&e.push({event:t,listeners:l})}var G5=/\r\n?/g,Q5=/\u0000|\uFFFD/g;function Au(e){return(typeof e=="string"?e:""+e).replace(G5,`
`).replace(Q5,"")}function Pi(e,t,n){if(t=Au(t),Au(e)!==t&&n)throw Error(R(425))}function io(){}var pa=null,ha=null;function ma(e,t){return e==="textarea"||e==="noscript"||typeof t.children=="string"||typeof t.children=="number"||typeof t.dangerouslySetInnerHTML=="object"&&t.dangerouslySetInnerHTML!==null&&t.dangerouslySetInnerHTML.__html!=null}var ga=typeof setTimeout=="function"?setTimeout:void 0,Y5=typeof clearTimeout=="function"?clearTimeout:void 0,$u=typeof Promise=="function"?Promise:void 0,K5=typeof queueMicrotask=="function"?queueMicrotask:typeof $u!="undefined"?function(e){return $u.resolve(null).then(e).catch(Z5)}:ga;function Z5(e){setTimeout(function(){throw e})}function zl(e,t){var n=t,r=0;do{var i=n.nextSibling;if(e.removeChild(n),i&&i.nodeType===8)if(n=i.data,n==="/$"){if(r===0){e.removeChild(i),Vr(t);return}r--}else n!=="$"&&n!=="$?"&&n!=="$!"||r++;n=i}while(n);Vr(t)}function Kt(e){for(;e!=null;e=e.nextSibling){var t=e.nodeType;if(t===1||t===3)break;if(t===8){if(t=e.data,t==="$"||t==="$!"||t==="$?")break;if(t==="/$")return null}}return e}function Iu(e){e=e.previousSibling;for(var t=0;e;){if(e.nodeType===8){var n=e.data;if(n==="$"||n==="$!"||n==="$?"){if(t===0)return e;t--}else n==="/$"&&t++}e=e.previousSibling}return null}var ur=Math.random().toString(36).slice(2),kt="__reactFiber$"+ur,Kr="__reactProps$"+ur,Mt="__reactContainer$"+ur,va="__reactEvents$"+ur,X5="__reactListeners$"+ur,J5="__reactHandles$"+ur;function fn(e){var t=e[kt];if(t)return t;for(var n=e.parentNode;n;){if(t=n[Mt]||n[kt]){if(n=t.alternate,t.child!==null||n!==null&&n.child!==null)for(e=Iu(e);e!==null;){if(n=e[kt])return n;e=Iu(e)}return t}e=n,n=e.parentNode}return null}function si(e){return e=e[kt]||e[Mt],!e||e.tag!==5&&e.tag!==6&&e.tag!==13&&e.tag!==3?null:e}function In(e){if(e.tag===5||e.tag===6)return e.stateNode;throw Error(R(33))}function To(e){return e[Kr]||null}var ya=[],Fn=-1;function an(e){return{current:e}}function le(e){0>Fn||(e.current=ya[Fn],ya[Fn]=null,Fn--)}function ie(e,t){Fn++,ya[Fn]=e.current,e.current=t}var on={},$e=an(on),Ye=an(!1),vn=on;function Jn(e,t){var n=e.type.contextTypes;if(!n)return on;var r=e.stateNode;if(r&&r.__reactInternalMemoizedUnmaskedChildContext===t)return r.__reactInternalMemoizedMaskedChildContext;var i={},o;for(o in n)i[o]=t[o];return r&&(e=e.stateNode,e.__reactInternalMemoizedUnmaskedChildContext=t,e.__reactInternalMemoizedMaskedChildContext=i),i}function Ke(e){return e=e.childContextTypes,e!=null}function oo(){le(Ye),le($e)}function Fu(e,t,n){if($e.current!==on)throw Error(R(168));ie($e,t),ie(Ye,n)}function s0(e,t,n){var r=e.stateNode;if(t=t.childContextTypes,typeof r.getChildContext!="function")return n;r=r.getChildContext();for(var i in r)if(!(i in t))throw Error(R(108,$f(e)||"Unknown",i));return ce({},n,r)}function lo(e){return e=(e=e.stateNode)&&e.__reactInternalMemoizedMergedChildContext||on,vn=$e.current,ie($e,e),ie(Ye,Ye.current),!0}function ju(e,t,n){var r=e.stateNode;if(!r)throw Error(R(169));n?(e=s0(e,t,vn),r.__reactInternalMemoizedMergedChildContext=e,le(Ye),le($e),ie($e,e)):le(Ye),ie(Ye,n)}var Lt=null,bo=!1,Rl=!1;function u0(e){Lt===null?Lt=[e]:Lt.push(e)}function q5(e){bo=!0,u0(e)}function sn(){if(!Rl&&Lt!==null){Rl=!0;var e=0,t=ee;try{var n=Lt;for(ee=1;e<n.length;e++){var r=n[e];do r=r(!0);while(r!==null)}Lt=null,bo=!1}catch(i){throw Lt!==null&&(Lt=Lt.slice(e+1)),Oc(ss,sn),i}finally{ee=t,Rl=!1}}return null}var jn=[],Dn=0,ao=null,so=0,ot=[],lt=0,yn=null,Nt=1,Tt="";function cn(e,t){jn[Dn++]=so,jn[Dn++]=ao,ao=e,so=t}function c0(e,t,n){ot[lt++]=Nt,ot[lt++]=Tt,ot[lt++]=yn,yn=e;var r=Nt;e=Tt;var i=32-vt(r)-1;r&=~(1<<i),n+=1;var o=32-vt(t)+i;if(30<o){var l=i-i%5;o=(r&(1<<l)-1).toString(32),r>>=l,i-=l,Nt=1<<32-vt(t)+i|n<<i|r,Tt=o+e}else Nt=1<<o|n<<i|r,Tt=e}function vs(e){e.return!==null&&(cn(e,1),c0(e,1,0))}function ys(e){for(;e===ao;)ao=jn[--Dn],jn[Dn]=null,so=jn[--Dn],jn[Dn]=null;for(;e===yn;)yn=ot[--lt],ot[lt]=null,Tt=ot[--lt],ot[lt]=null,Nt=ot[--lt],ot[lt]=null}var et=null,Je=null,ae=!1,mt=null;function d0(e,t){var n=at(5,null,null,0);n.elementType="DELETED",n.stateNode=t,n.return=e,t=e.deletions,t===null?(e.deletions=[n],e.flags|=16):t.push(n)}function Du(e,t){switch(e.tag){case 5:var n=e.type;return t=t.nodeType!==1||n.toLowerCase()!==t.nodeName.toLowerCase()?null:t,t!==null?(e.stateNode=t,et=e,Je=Kt(t.firstChild),!0):!1;case 6:return t=e.pendingProps===""||t.nodeType!==3?null:t,t!==null?(e.stateNode=t,et=e,Je=null,!0):!1;case 13:return t=t.nodeType!==8?null:t,t!==null?(n=yn!==null?{id:Nt,overflow:Tt}:null,e.memoizedState={dehydrated:t,treeContext:n,retryLane:1073741824},n=at(18,null,null,0),n.stateNode=t,n.return=e,e.child=n,et=e,Je=null,!0):!1;default:return!1}}function wa(e){return(e.mode&1)!==0&&(e.flags&128)===0}function xa(e){if(ae){var t=Je;if(t){var n=t;if(!Du(e,t)){if(wa(e))throw Error(R(418));t=Kt(n.nextSibling);var r=et;t&&Du(e,t)?d0(r,n):(e.flags=e.flags&-4097|2,ae=!1,et=e)}}else{if(wa(e))throw Error(R(418));e.flags=e.flags&-4097|2,ae=!1,et=e}}}function Bu(e){for(e=e.return;e!==null&&e.tag!==5&&e.tag!==3&&e.tag!==13;)e=e.return;et=e}function zi(e){if(e!==et)return!1;if(!ae)return Bu(e),ae=!0,!1;var t;if((t=e.tag!==3)&&!(t=e.tag!==5)&&(t=e.type,t=t!=="head"&&t!=="body"&&!ma(e.type,e.memoizedProps)),t&&(t=Je)){if(wa(e))throw f0(),Error(R(418));for(;t;)d0(e,t),t=Kt(t.nextSibling)}if(Bu(e),e.tag===13){if(e=e.memoizedState,e=e!==null?e.dehydrated:null,!e)throw Error(R(317));e:{for(e=e.nextSibling,t=0;e;){if(e.nodeType===8){var n=e.data;if(n==="/$"){if(t===0){Je=Kt(e.nextSibling);break e}t--}else n!=="$"&&n!=="$!"&&n!=="$?"||t++}e=e.nextSibling}Je=null}}else Je=et?Kt(e.stateNode.nextSibling):null;return!0}function f0(){for(var e=Je;e;)e=Kt(e.nextSibling)}function qn(){Je=et=null,ae=!1}function ws(e){mt===null?mt=[e]:mt.push(e)}var e2=$t.ReactCurrentBatchConfig;function pt(e,t){if(e&&e.defaultProps){t=ce({},t),e=e.defaultProps;for(var n in e)t[n]===void 0&&(t[n]=e[n]);return t}return t}var uo=an(null),co=null,Bn=null,xs=null;function Cs(){xs=Bn=co=null}function ks(e){var t=uo.current;le(uo),e._currentValue=t}function Ca(e,t,n){for(;e!==null;){var r=e.alternate;if((e.childLanes&t)!==t?(e.childLanes|=t,r!==null&&(r.childLanes|=t)):r!==null&&(r.childLanes&t)!==t&&(r.childLanes|=t),e===n)break;e=e.return}}function Kn(e,t){co=e,xs=Bn=null,e=e.dependencies,e!==null&&e.firstContext!==null&&((e.lanes&t)!==0&&(Ge=!0),e.firstContext=null)}function ut(e){var t=e._currentValue;if(xs!==e)if(e={context:e,memoizedValue:t,next:null},Bn===null){if(co===null)throw Error(R(308));Bn=e,co.dependencies={lanes:0,firstContext:e}}else Bn=Bn.next=e;return t}var pn=null;function Ss(e){pn===null?pn=[e]:pn.push(e)}function p0(e,t,n,r){var i=t.interleaved;return i===null?(n.next=n,Ss(t)):(n.next=i.next,i.next=n),t.interleaved=n,Ot(e,r)}function Ot(e,t){e.lanes|=t;var n=e.alternate;for(n!==null&&(n.lanes|=t),n=e,e=e.return;e!==null;)e.childLanes|=t,n=e.alternate,n!==null&&(n.childLanes|=t),n=e,e=e.return;return n.tag===3?n.stateNode:null}var Dt=!1;function Es(e){e.updateQueue={baseState:e.memoizedState,firstBaseUpdate:null,lastBaseUpdate:null,shared:{pending:null,interleaved:null,lanes:0},effects:null}}function h0(e,t){e=e.updateQueue,t.updateQueue===e&&(t.updateQueue={baseState:e.baseState,firstBaseUpdate:e.firstBaseUpdate,lastBaseUpdate:e.lastBaseUpdate,shared:e.shared,effects:e.effects})}function bt(e,t){return{eventTime:e,lane:t,tag:0,payload:null,callback:null,next:null}}function Zt(e,t,n){var r=e.updateQueue;if(r===null)return null;if(r=r.shared,(K&2)!==0){var i=r.pending;return i===null?t.next=t:(t.next=i.next,i.next=t),r.pending=t,Ot(e,n)}return i=r.interleaved,i===null?(t.next=t,Ss(r)):(t.next=i.next,i.next=t),r.interleaved=t,Ot(e,n)}function ji(e,t,n){if(t=t.updateQueue,t!==null&&(t=t.shared,(n&4194240)!==0)){var r=t.lanes;r&=e.pendingLanes,n|=r,t.lanes=n,us(e,n)}}function Hu(e,t){var n=e.updateQueue,r=e.alternate;if(r!==null&&(r=r.updateQueue,n===r)){var i=null,o=null;if(n=n.firstBaseUpdate,n!==null){do{var l={eventTime:n.eventTime,lane:n.lane,tag:n.tag,payload:n.payload,callback:n.callback,next:null};o===null?i=o=l:o=o.next=l,n=n.next}while(n!==null);o===null?i=o=t:o=o.next=t}else i=o=t;n={baseState:r.baseState,firstBaseUpdate:i,lastBaseUpdate:o,shared:r.shared,effects:r.effects},e.updateQueue=n;return}e=n.lastBaseUpdate,e===null?n.firstBaseUpdate=t:e.next=t,n.lastBaseUpdate=t}function fo(e,t,n,r){var i=e.updateQueue;Dt=!1;var o=i.firstBaseUpdate,l=i.lastBaseUpdate,s=i.shared.pending;if(s!==null){i.shared.pending=null;var u=s,c=u.next;u.next=null,l===null?o=c:l.next=c,l=u;var p=e.alternate;p!==null&&(p=p.updateQueue,s=p.lastBaseUpdate,s!==l&&(s===null?p.firstBaseUpdate=c:s.next=c,p.lastBaseUpdate=u))}if(o!==null){var g=i.baseState;l=0,p=c=u=null,s=o;do{var m=s.lane,C=s.eventTime;if((r&m)===m){p!==null&&(p=p.next={eventTime:C,lane:0,tag:s.tag,payload:s.payload,callback:s.callback,next:null});e:{var y=e,w=s;switch(m=t,C=n,w.tag){case 1:if(y=w.payload,typeof y=="function"){g=y.call(C,g,m);break e}g=y;break e;case 3:y.flags=y.flags&-65537|128;case 0:if(y=w.payload,m=typeof y=="function"?y.call(C,g,m):y,m==null)break e;g=ce({},g,m);break e;case 2:Dt=!0}}s.callback!==null&&s.lane!==0&&(e.flags|=64,m=i.effects,m===null?i.effects=[s]:m.push(s))}else C={eventTime:C,lane:m,tag:s.tag,payload:s.payload,callback:s.callback,next:null},p===null?(c=p=C,u=g):p=p.next=C,l|=m;if(s=s.next,s===null){if(s=i.shared.pending,s===null)break;m=s,s=m.next,m.next=null,i.lastBaseUpdate=m,i.shared.pending=null}}while(1);if(p===null&&(u=g),i.baseState=u,i.firstBaseUpdate=c,i.lastBaseUpdate=p,t=i.shared.interleaved,t!==null){i=t;do l|=i.lane,i=i.next;while(i!==t)}else o===null&&(i.shared.lanes=0);xn|=l,e.lanes=l,e.memoizedState=g}}function Uu(e,t,n){if(e=t.effects,t.effects=null,e!==null)for(t=0;t<e.length;t++){var r=e[t],i=r.callback;if(i!==null){if(r.callback=null,r=n,typeof i!="function")throw Error(R(191,i));i.call(r)}}}var m0=new pc.Component().refs;function ka(e,t,n,r){t=e.memoizedState,n=n(r,t),n=n==null?t:ce({},t,n),e.memoizedState=n,e.lanes===0&&(e.updateQueue.baseState=n)}var _o={isMounted:function(e){return(e=e._reactInternals)?Pn(e)===e:!1},enqueueSetState:function(e,t,n){e=e._reactInternals;var r=De(),i=Jt(e),o=bt(r,i);o.payload=t,n!=null&&(o.callback=n),t=Zt(e,o,i),t!==null&&(yt(t,e,i,r),ji(t,e,i))},enqueueReplaceState:function(e,t,n){e=e._reactInternals;var r=De(),i=Jt(e),o=bt(r,i);o.tag=1,o.payload=t,n!=null&&(o.callback=n),t=Zt(e,o,i),t!==null&&(yt(t,e,i,r),ji(t,e,i))},enqueueForceUpdate:function(e,t){e=e._reactInternals;var n=De(),r=Jt(e),i=bt(n,r);i.tag=2,t!=null&&(i.callback=t),t=Zt(e,i,r),t!==null&&(yt(t,e,r,n),ji(t,e,r))}};function Vu(e,t,n,r,i,o,l){return e=e.stateNode,typeof e.shouldComponentUpdate=="function"?e.shouldComponentUpdate(r,o,l):t.prototype&&t.prototype.isPureReactComponent?!Gr(n,r)||!Gr(i,o):!0}function g0(e,t,n){var r=!1,i=on,o=t.contextType;return typeof o=="object"&&o!==null?o=ut(o):(i=Ke(t)?vn:$e.current,r=t.contextTypes,o=(r=r!=null)?Jn(e,i):on),t=new t(n,o),e.memoizedState=t.state!==null&&t.state!==void 0?t.state:null,t.updater=_o,e.stateNode=t,t._reactInternals=e,r&&(e=e.stateNode,e.__reactInternalMemoizedUnmaskedChildContext=i,e.__reactInternalMemoizedMaskedChildContext=o),t}function Wu(e,t,n,r){e=t.state,typeof t.componentWillReceiveProps=="function"&&t.componentWillReceiveProps(n,r),typeof t.UNSAFE_componentWillReceiveProps=="function"&&t.UNSAFE_componentWillReceiveProps(n,r),t.state!==e&&_o.enqueueReplaceState(t,t.state,null)}function Sa(e,t,n,r){var i=e.stateNode;i.props=n,i.state=e.memoizedState,i.refs=m0,Es(e);var o=t.contextType;typeof o=="object"&&o!==null?i.context=ut(o):(o=Ke(t)?vn:$e.current,i.context=Jn(e,o)),i.state=e.memoizedState,o=t.getDerivedStateFromProps,typeof o=="function"&&(ka(e,t,o,n),i.state=e.memoizedState),typeof t.getDerivedStateFromProps=="function"||typeof i.getSnapshotBeforeUpdate=="function"||typeof i.UNSAFE_componentWillMount!="function"&&typeof i.componentWillMount!="function"||(t=i.state,typeof i.componentWillMount=="function"&&i.componentWillMount(),typeof i.UNSAFE_componentWillMount=="function"&&i.UNSAFE_componentWillMount(),t!==i.state&&_o.enqueueReplaceState(i,i.state,null),fo(e,n,i,r),i.state=e.memoizedState),typeof i.componentDidMount=="function"&&(e.flags|=4194308)}function Cr(e,t,n){if(e=n.ref,e!==null&&typeof e!="function"&&typeof e!="object"){if(n._owner){if(n=n._owner,n){if(n.tag!==1)throw Error(R(309));var r=n.stateNode}if(!r)throw Error(R(147,e));var i=r,o=""+e;return t!==null&&t.ref!==null&&typeof t.ref=="function"&&t.ref._stringRef===o?t.ref:(t=function(l){var s=i.refs;s===m0&&(s=i.refs={}),l===null?delete s[o]:s[o]=l},t._stringRef=o,t)}if(typeof e!="string")throw Error(R(284));if(!n._owner)throw Error(R(290,e))}return e}function Ri(e,t){throw e=Object.prototype.toString.call(t),Error(R(31,e==="[object Object]"?"object with keys {"+Object.keys(t).join(", ")+"}":e))}function Gu(e){var t=e._init;return t(e._payload)}function v0(e){function t(f,d){if(e){var h=f.deletions;h===null?(f.deletions=[d],f.flags|=16):h.push(d)}}function n(f,d){if(!e)return null;for(;d!==null;)t(f,d),d=d.sibling;return null}function r(f,d){for(f=new Map;d!==null;)d.key!==null?f.set(d.key,d):f.set(d.index,d),d=d.sibling;return f}function i(f,d){return f=qt(f,d),f.index=0,f.sibling=null,f}function o(f,d,h){return f.index=h,e?(h=f.alternate,h!==null?(h=h.index,h<d?(f.flags|=2,d):h):(f.flags|=2,d)):(f.flags|=1048576,d)}function l(f){return e&&f.alternate===null&&(f.flags|=2),f}function s(f,d,h,k){return d===null||d.tag!==6?(d=Ol(h,f.mode,k),d.return=f,d):(d=i(d,h),d.return=f,d)}function u(f,d,h,k){var z=h.type;return z===Mn?p(f,d,h.props.children,k,h.key):d!==null&&(d.elementType===z||typeof z=="object"&&z!==null&&z.$$typeof===jt&&Gu(z)===d.type)?(k=i(d,h.props),k.ref=Cr(f,d,h),k.return=f,k):(k=Wi(h.type,h.key,h.props,null,f.mode,k),k.ref=Cr(f,d,h),k.return=f,k)}function c(f,d,h,k){return d===null||d.tag!==4||d.stateNode.containerInfo!==h.containerInfo||d.stateNode.implementation!==h.implementation?(d=Al(h,f.mode,k),d.return=f,d):(d=i(d,h.children||[]),d.return=f,d)}function p(f,d,h,k,z){return d===null||d.tag!==7?(d=gn(h,f.mode,k,z),d.return=f,d):(d=i(d,h),d.return=f,d)}function g(f,d,h){if(typeof d=="string"&&d!==""||typeof d=="number")return d=Ol(""+d,f.mode,h),d.return=f,d;if(typeof d=="object"&&d!==null){switch(d.$$typeof){case gi:return h=Wi(d.type,d.key,d.props,null,f.mode,h),h.ref=Cr(f,null,d),h.return=f,h;case _n:return d=Al(d,f.mode,h),d.return=f,d;case jt:var k=d._init;return g(f,k(d._payload),h)}if(Pr(d)||gr(d))return d=gn(d,f.mode,h,null),d.return=f,d;Ri(f,d)}return null}function m(f,d,h,k){var z=d!==null?d.key:null;if(typeof h=="string"&&h!==""||typeof h=="number")return z!==null?null:s(f,d,""+h,k);if(typeof h=="object"&&h!==null){switch(h.$$typeof){case gi:return h.key===z?u(f,d,h,k):null;case _n:return h.key===z?c(f,d,h,k):null;case jt:return z=h._init,m(f,d,z(h._payload),k)}if(Pr(h)||gr(h))return z!==null?null:p(f,d,h,k,null);Ri(f,h)}return null}function C(f,d,h,k,z){if(typeof k=="string"&&k!==""||typeof k=="number")return f=f.get(h)||null,s(d,f,""+k,z);if(typeof k=="object"&&k!==null){switch(k.$$typeof){case gi:return f=f.get(k.key===null?h:k.key)||null,u(d,f,k,z);case _n:return f=f.get(k.key===null?h:k.key)||null,c(d,f,k,z);case jt:var _=k._init;return C(f,d,h,_(k._payload),z)}if(Pr(k)||gr(k))return f=f.get(h)||null,p(d,f,k,z,null);Ri(d,k)}return null}function y(f,d,h,k){for(var z=null,_=null,M=d,b=d=0,V=null;M!==null&&b<h.length;b++){M.index>b?(V=M,M=null):V=M.sibling;var I=m(f,M,h[b],k);if(I===null){M===null&&(M=V);break}e&&M&&I.alternate===null&&t(f,M),d=o(I,d,b),_===null?z=I:_.sibling=I,_=I,M=V}if(b===h.length)return n(f,M),ae&&cn(f,b),z;if(M===null){for(;b<h.length;b++)M=g(f,h[b],k),M!==null&&(d=o(M,d,b),_===null?z=M:_.sibling=M,_=M);return ae&&cn(f,b),z}for(M=r(f,M);b<h.length;b++)V=C(M,f,b,h[b],k),V!==null&&(e&&V.alternate!==null&&M.delete(V.key===null?b:V.key),d=o(V,d,b),_===null?z=V:_.sibling=V,_=V);return e&&M.forEach(function(H){return t(f,H)}),ae&&cn(f,b),z}function w(f,d,h,k){var z=gr(h);if(typeof z!="function")throw Error(R(150));if(h=z.call(h),h==null)throw Error(R(151));for(var _=z=null,M=d,b=d=0,V=null,I=h.next();M!==null&&!I.done;b++,I=h.next()){M.index>b?(V=M,M=null):V=M.sibling;var H=m(f,M,I.value,k);if(H===null){M===null&&(M=V);break}e&&M&&H.alternate===null&&t(f,M),d=o(H,d,b),_===null?z=H:_.sibling=H,_=H,M=V}if(I.done)return n(f,M),ae&&cn(f,b),z;if(M===null){for(;!I.done;b++,I=h.next())I=g(f,I.value,k),I!==null&&(d=o(I,d,b),_===null?z=I:_.sibling=I,_=I);return ae&&cn(f,b),z}for(M=r(f,M);!I.done;b++,I=h.next())I=C(M,f,b,I.value,k),I!==null&&(e&&I.alternate!==null&&M.delete(I.key===null?b:I.key),d=o(I,d,b),_===null?z=I:_.sibling=I,_=I);return e&&M.forEach(function(Q){return t(f,Q)}),ae&&cn(f,b),z}function P(f,d,h,k){if(typeof h=="object"&&h!==null&&h.type===Mn&&h.key===null&&(h=h.props.children),typeof h=="object"&&h!==null){switch(h.$$typeof){case gi:e:{for(var z=h.key,_=d;_!==null;){if(_.key===z){if(z=h.type,z===Mn){if(_.tag===7){n(f,_.sibling),d=i(_,h.props.children),d.return=f,f=d;break e}}else if(_.elementType===z||typeof z=="object"&&z!==null&&z.$$typeof===jt&&Gu(z)===_.type){n(f,_.sibling),d=i(_,h.props),d.ref=Cr(f,_,h),d.return=f,f=d;break e}n(f,_);break}else t(f,_);_=_.sibling}h.type===Mn?(d=gn(h.props.children,f.mode,k,h.key),d.return=f,f=d):(k=Wi(h.type,h.key,h.props,null,f.mode,k),k.ref=Cr(f,d,h),k.return=f,f=k)}return l(f);case _n:e:{for(_=h.key;d!==null;){if(d.key===_)if(d.tag===4&&d.stateNode.containerInfo===h.containerInfo&&d.stateNode.implementation===h.implementation){n(f,d.sibling),d=i(d,h.children||[]),d.return=f,f=d;break e}else{n(f,d);break}else t(f,d);d=d.sibling}d=Al(h,f.mode,k),d.return=f,f=d}return l(f);case jt:return _=h._init,P(f,d,_(h._payload),k)}if(Pr(h))return y(f,d,h,k);if(gr(h))return w(f,d,h,k);Ri(f,h)}return typeof h=="string"&&h!==""||typeof h=="number"?(h=""+h,d!==null&&d.tag===6?(n(f,d.sibling),d=i(d,h),d.return=f,f=d):(n(f,d),d=Ol(h,f.mode,k),d.return=f,f=d),l(f)):n(f,d)}return P}var er=v0(!0),y0=v0(!1),ui={},Et=an(ui),Zr=an(ui),Xr=an(ui);function hn(e){if(e===ui)throw Error(R(174));return e}function Ps(e,t){switch(ie(Xr,t),ie(Zr,e),ie(Et,ui),e=t.nodeType,e){case 9:case 11:t=(t=t.documentElement)?t.namespaceURI:ta(null,"");break;default:e=e===8?t.parentNode:t,t=e.namespaceURI||null,e=e.tagName,t=ta(t,e)}le(Et),ie(Et,t)}function tr(){le(Et),le(Zr),le(Xr)}function w0(e){hn(Xr.current);var t=hn(Et.current),n=ta(t,e.type);t!==n&&(ie(Zr,e),ie(Et,n))}function zs(e){Zr.current===e&&(le(Et),le(Zr))}var se=an(0);function po(e){for(var t=e;t!==null;){if(t.tag===13){var n=t.memoizedState;if(n!==null&&(n=n.dehydrated,n===null||n.data==="$?"||n.data==="$!"))return t}else if(t.tag===19&&t.memoizedProps.revealOrder!==void 0){if((t.flags&128)!==0)return t}else if(t.child!==null){t.child.return=t,t=t.child;continue}if(t===e)break;for(;t.sibling===null;){if(t.return===null||t.return===e)return null;t=t.return}t.sibling.return=t.return,t=t.sibling}return null}var Ll=[];function Rs(){for(var e=0;e<Ll.length;e++)Ll[e]._workInProgressVersionPrimary=null;Ll.length=0}var Di=$t.ReactCurrentDispatcher,Nl=$t.ReactCurrentBatchConfig,wn=0,ue=null,ye=null,Ce=null,ho=!1,Or=!1,Jr=0,t2=0;function Me(){throw Error(R(321))}function Ls(e,t){if(t===null)return!1;for(var n=0;n<t.length&&n<e.length;n++)if(!wt(e[n],t[n]))return!1;return!0}function Ns(e,t,n,r,i,o){if(wn=o,ue=t,t.memoizedState=null,t.updateQueue=null,t.lanes=0,Di.current=e===null||e.memoizedState===null?o2:l2,e=n(r,i),Or){o=0;do{if(Or=!1,Jr=0,25<=o)throw Error(R(301));o+=1,Ce=ye=null,t.updateQueue=null,Di.current=a2,e=n(r,i)}while(Or)}if(Di.current=mo,t=ye!==null&&ye.next!==null,wn=0,Ce=ye=ue=null,ho=!1,t)throw Error(R(300));return e}function Ts(){var e=Jr!==0;return Jr=0,e}function Ct(){var e={memoizedState:null,baseState:null,baseQueue:null,queue:null,next:null};return Ce===null?ue.memoizedState=Ce=e:Ce=Ce.next=e,Ce}function ct(){if(ye===null){var e=ue.alternate;e=e!==null?e.memoizedState:null}else e=ye.next;var t=Ce===null?ue.memoizedState:Ce.next;if(t!==null)Ce=t,ye=e;else{if(e===null)throw Error(R(310));ye=e,e={memoizedState:ye.memoizedState,baseState:ye.baseState,baseQueue:ye.baseQueue,queue:ye.queue,next:null},Ce===null?ue.memoizedState=Ce=e:Ce=Ce.next=e}return Ce}function qr(e,t){return typeof t=="function"?t(e):t}function Tl(e){var t=ct(),n=t.queue;if(n===null)throw Error(R(311));n.lastRenderedReducer=e;var r=ye,i=r.baseQueue,o=n.pending;if(o!==null){if(i!==null){var l=i.next;i.next=o.next,o.next=l}r.baseQueue=i=o,n.pending=null}if(i!==null){o=i.next,r=r.baseState;var s=l=null,u=null,c=o;do{var p=c.lane;if((wn&p)===p)u!==null&&(u=u.next={lane:0,action:c.action,hasEagerState:c.hasEagerState,eagerState:c.eagerState,next:null}),r=c.hasEagerState?c.eagerState:e(r,c.action);else{var g={lane:p,action:c.action,hasEagerState:c.hasEagerState,eagerState:c.eagerState,next:null};u===null?(s=u=g,l=r):u=u.next=g,ue.lanes|=p,xn|=p}c=c.next}while(c!==null&&c!==o);u===null?l=r:u.next=s,wt(r,t.memoizedState)||(Ge=!0),t.memoizedState=r,t.baseState=l,t.baseQueue=u,n.lastRenderedState=r}if(e=n.interleaved,e!==null){i=e;do o=i.lane,ue.lanes|=o,xn|=o,i=i.next;while(i!==e)}else i===null&&(n.lanes=0);return[t.memoizedState,n.dispatch]}function bl(e){var t=ct(),n=t.queue;if(n===null)throw Error(R(311));n.lastRenderedReducer=e;var r=n.dispatch,i=n.pending,o=t.memoizedState;if(i!==null){n.pending=null;var l=i=i.next;do o=e(o,l.action),l=l.next;while(l!==i);wt(o,t.memoizedState)||(Ge=!0),t.memoizedState=o,t.baseQueue===null&&(t.baseState=o),n.lastRenderedState=o}return[o,r]}function x0(){}function C0(e,t){var n=ue,r=ct(),i=t(),o=!wt(r.memoizedState,i);if(o&&(r.memoizedState=i,Ge=!0),r=r.queue,bs(E0.bind(null,n,r,e),[e]),r.getSnapshot!==t||o||Ce!==null&&Ce.memoizedState.tag&1){if(n.flags|=2048,ei(9,S0.bind(null,n,r,i,t),void 0,null),ke===null)throw Error(R(349));(wn&30)!==0||k0(n,t,i)}return i}function k0(e,t,n){e.flags|=16384,e={getSnapshot:t,value:n},t=ue.updateQueue,t===null?(t={lastEffect:null,stores:null},ue.updateQueue=t,t.stores=[e]):(n=t.stores,n===null?t.stores=[e]:n.push(e))}function S0(e,t,n,r){t.value=n,t.getSnapshot=r,P0(t)&&z0(e)}function E0(e,t,n){return n(function(){P0(t)&&z0(e)})}function P0(e){var t=e.getSnapshot;e=e.value;try{var n=t();return!wt(e,n)}catch{return!0}}function z0(e){var t=Ot(e,1);t!==null&&yt(t,e,1,-1)}function Qu(e){var t=Ct();return typeof e=="function"&&(e=e()),t.memoizedState=t.baseState=e,e={pending:null,interleaved:null,lanes:0,dispatch:null,lastRenderedReducer:qr,lastRenderedState:e},t.queue=e,e=e.dispatch=i2.bind(null,ue,e),[t.memoizedState,e]}function ei(e,t,n,r){return e={tag:e,create:t,destroy:n,deps:r,next:null},t=ue.updateQueue,t===null?(t={lastEffect:null,stores:null},ue.updateQueue=t,t.lastEffect=e.next=e):(n=t.lastEffect,n===null?t.lastEffect=e.next=e:(r=n.next,n.next=e,e.next=r,t.lastEffect=e)),e}function R0(){return ct().memoizedState}function Bi(e,t,n,r){var i=Ct();ue.flags|=e,i.memoizedState=ei(1|t,n,void 0,r===void 0?null:r)}function Mo(e,t,n,r){var i=ct();r=r===void 0?null:r;var o=void 0;if(ye!==null){var l=ye.memoizedState;if(o=l.destroy,r!==null&&Ls(r,l.deps)){i.memoizedState=ei(t,n,o,r);return}}ue.flags|=e,i.memoizedState=ei(1|t,n,o,r)}function Yu(e,t){return Bi(8390656,8,e,t)}function bs(e,t){return Mo(2048,8,e,t)}function L0(e,t){return Mo(4,2,e,t)}function N0(e,t){return Mo(4,4,e,t)}function T0(e,t){if(typeof t=="function")return e=e(),t(e),function(){t(null)};if(t!=null)return e=e(),t.current=e,function(){t.current=null}}function b0(e,t,n){return n=n!=null?n.concat([e]):null,Mo(4,4,T0.bind(null,t,e),n)}function _s(){}function _0(e,t){var n=ct();t=t===void 0?null:t;var r=n.memoizedState;return r!==null&&t!==null&&Ls(t,r[1])?r[0]:(n.memoizedState=[e,t],e)}function M0(e,t){var n=ct();t=t===void 0?null:t;var r=n.memoizedState;return r!==null&&t!==null&&Ls(t,r[1])?r[0]:(e=e(),n.memoizedState=[e,t],e)}function O0(e,t,n){return(wn&21)===0?(e.baseState&&(e.baseState=!1,Ge=!0),e.memoizedState=n):(wt(n,t)||(n=Ic(),ue.lanes|=n,xn|=n,e.baseState=!0),t)}function n2(e,t){var n=ee;ee=n!==0&&4>n?n:4,e(!0);var r=Nl.transition;Nl.transition={};try{e(!1),t()}finally{ee=n,Nl.transition=r}}function A0(){return ct().memoizedState}function r2(e,t,n){var r=Jt(e);if(n={lane:r,action:n,hasEagerState:!1,eagerState:null,next:null},$0(e))I0(t,n);else if(n=p0(e,t,n,r),n!==null){var i=De();yt(n,e,r,i),F0(n,t,r)}}function i2(e,t,n){var r=Jt(e),i={lane:r,action:n,hasEagerState:!1,eagerState:null,next:null};if($0(e))I0(t,i);else{var o=e.alternate;if(e.lanes===0&&(o===null||o.lanes===0)&&(o=t.lastRenderedReducer,o!==null))try{var l=t.lastRenderedState,s=o(l,n);if(i.hasEagerState=!0,i.eagerState=s,wt(s,l)){var u=t.interleaved;u===null?(i.next=i,Ss(t)):(i.next=u.next,u.next=i),t.interleaved=i;return}}catch{}finally{}n=p0(e,t,i,r),n!==null&&(i=De(),yt(n,e,r,i),F0(n,t,r))}}function $0(e){var t=e.alternate;return e===ue||t!==null&&t===ue}function I0(e,t){Or=ho=!0;var n=e.pending;n===null?t.next=t:(t.next=n.next,n.next=t),e.pending=t}function F0(e,t,n){if((n&4194240)!==0){var r=t.lanes;r&=e.pendingLanes,n|=r,t.lanes=n,us(e,n)}}var mo={readContext:ut,useCallback:Me,useContext:Me,useEffect:Me,useImperativeHandle:Me,useInsertionEffect:Me,useLayoutEffect:Me,useMemo:Me,useReducer:Me,useRef:Me,useState:Me,useDebugValue:Me,useDeferredValue:Me,useTransition:Me,useMutableSource:Me,useSyncExternalStore:Me,useId:Me,unstable_isNewReconciler:!1},o2={readContext:ut,useCallback:function(e,t){return Ct().memoizedState=[e,t===void 0?null:t],e},useContext:ut,useEffect:Yu,useImperativeHandle:function(e,t,n){return n=n!=null?n.concat([e]):null,Bi(4194308,4,T0.bind(null,t,e),n)},useLayoutEffect:function(e,t){return Bi(4194308,4,e,t)},useInsertionEffect:function(e,t){return Bi(4,2,e,t)},useMemo:function(e,t){var n=Ct();return t=t===void 0?null:t,e=e(),n.memoizedState=[e,t],e},useReducer:function(e,t,n){var r=Ct();return t=n!==void 0?n(t):t,r.memoizedState=r.baseState=t,e={pending:null,interleaved:null,lanes:0,dispatch:null,lastRenderedReducer:e,lastRenderedState:t},r.queue=e,e=e.dispatch=r2.bind(null,ue,e),[r.memoizedState,e]},useRef:function(e){var t=Ct();return e={current:e},t.memoizedState=e},useState:Qu,useDebugValue:_s,useDeferredValue:function(e){return Ct().memoizedState=e},useTransition:function(){var e=Qu(!1),t=e[0];return e=n2.bind(null,e[1]),Ct().memoizedState=e,[t,e]},useMutableSource:function(){},useSyncExternalStore:function(e,t,n){var r=ue,i=Ct();if(ae){if(n===void 0)throw Error(R(407));n=n()}else{if(n=t(),ke===null)throw Error(R(349));(wn&30)!==0||k0(r,t,n)}i.memoizedState=n;var o={value:n,getSnapshot:t};return i.queue=o,Yu(E0.bind(null,r,o,e),[e]),r.flags|=2048,ei(9,S0.bind(null,r,o,n,t),void 0,null),n},useId:function(){var e=Ct(),t=ke.identifierPrefix;if(ae){var n=Tt,r=Nt;n=(r&~(1<<32-vt(r)-1)).toString(32)+n,t=":"+t+"R"+n,n=Jr++,0<n&&(t+="H"+n.toString(32)),t+=":"}else n=t2++,t=":"+t+"r"+n.toString(32)+":";return e.memoizedState=t},unstable_isNewReconciler:!1},l2={readContext:ut,useCallback:_0,useContext:ut,useEffect:bs,useImperativeHandle:b0,useInsertionEffect:L0,useLayoutEffect:N0,useMemo:M0,useReducer:Tl,useRef:R0,useState:function(){return Tl(qr)},useDebugValue:_s,useDeferredValue:function(e){var t=ct();return O0(t,ye.memoizedState,e)},useTransition:function(){var e=Tl(qr)[0],t=ct().memoizedState;return[e,t]},useMutableSource:x0,useSyncExternalStore:C0,useId:A0,unstable_isNewReconciler:!1},a2={readContext:ut,useCallback:_0,useContext:ut,useEffect:bs,useImperativeHandle:b0,useInsertionEffect:L0,useLayoutEffect:N0,useMemo:M0,useReducer:bl,useRef:R0,useState:function(){return bl(qr)},useDebugValue:_s,useDeferredValue:function(e){var t=ct();return ye===null?t.memoizedState=e:O0(t,ye.memoizedState,e)},useTransition:function(){var e=bl(qr)[0],t=ct().memoizedState;return[e,t]},useMutableSource:x0,useSyncExternalStore:C0,useId:A0,unstable_isNewReconciler:!1};function nr(e,t){try{var n="",r=t;do n+=Af(r),r=r.return;while(r);var i=n}catch(o){i=`
Error generating stack: `+o.message+`
`+o.stack}return{value:e,source:t,stack:i,digest:null}}function _l(e,t,n){return{value:e,source:null,stack:n!=null?n:null,digest:t!=null?t:null}}function Ea(e,t){try{console.error(t.value)}catch(n){setTimeout(function(){throw n})}}var s2=typeof WeakMap=="function"?WeakMap:Map;function j0(e,t,n){n=bt(-1,n),n.tag=3,n.payload={element:null};var r=t.value;return n.callback=function(){vo||(vo=!0,Oa=r),Ea(e,t)},n}function D0(e,t,n){n=bt(-1,n),n.tag=3;var r=e.type.getDerivedStateFromError;if(typeof r=="function"){var i=t.value;n.payload=function(){return r(i)},n.callback=function(){Ea(e,t)}}var o=e.stateNode;return o!==null&&typeof o.componentDidCatch=="function"&&(n.callback=function(){Ea(e,t),typeof r!="function"&&(Xt===null?Xt=new Set([this]):Xt.add(this));var l=t.stack;this.componentDidCatch(t.value,{componentStack:l!==null?l:""})}),n}function Ku(e,t,n){var r=e.pingCache;if(r===null){r=e.pingCache=new s2;var i=new Set;r.set(t,i)}else i=r.get(t),i===void 0&&(i=new Set,r.set(t,i));i.has(n)||(i.add(n),e=k2.bind(null,e,t,n),t.then(e,e))}function Zu(e){do{var t;if((t=e.tag===13)&&(t=e.memoizedState,t=t!==null?t.dehydrated!==null:!0),t)return e;e=e.return}while(e!==null);return null}function Xu(e,t,n,r,i){return(e.mode&1)===0?(e===t?e.flags|=65536:(e.flags|=128,n.flags|=131072,n.flags&=-52805,n.tag===1&&(n.alternate===null?n.tag=17:(t=bt(-1,1),t.tag=2,Zt(n,t,1))),n.lanes|=1),e):(e.flags|=65536,e.lanes=i,e)}var u2=$t.ReactCurrentOwner,Ge=!1;function je(e,t,n,r){t.child=e===null?y0(t,null,n,r):er(t,e.child,n,r)}function Ju(e,t,n,r,i){n=n.render;var o=t.ref;return Kn(t,i),r=Ns(e,t,n,r,o,i),n=Ts(),e!==null&&!Ge?(t.updateQueue=e.updateQueue,t.flags&=-2053,e.lanes&=~i,At(e,t,i)):(ae&&n&&vs(t),t.flags|=1,je(e,t,r,i),t.child)}function qu(e,t,n,r,i){if(e===null){var o=n.type;return typeof o=="function"&&!Ds(o)&&o.defaultProps===void 0&&n.compare===null&&n.defaultProps===void 0?(t.tag=15,t.type=o,B0(e,t,o,r,i)):(e=Wi(n.type,null,r,t,t.mode,i),e.ref=t.ref,e.return=t,t.child=e)}if(o=e.child,(e.lanes&i)===0){var l=o.memoizedProps;if(n=n.compare,n=n!==null?n:Gr,n(l,r)&&e.ref===t.ref)return At(e,t,i)}return t.flags|=1,e=qt(o,r),e.ref=t.ref,e.return=t,t.child=e}function B0(e,t,n,r,i){if(e!==null){var o=e.memoizedProps;if(Gr(o,r)&&e.ref===t.ref)if(Ge=!1,t.pendingProps=r=o,(e.lanes&i)!==0)(e.flags&131072)!==0&&(Ge=!0);else return t.lanes=e.lanes,At(e,t,i)}return Pa(e,t,n,r,i)}function H0(e,t,n){var r=t.pendingProps,i=r.children,o=e!==null?e.memoizedState:null;if(r.mode==="hidden")if((t.mode&1)===0)t.memoizedState={baseLanes:0,cachePool:null,transitions:null},ie(Un,Xe),Xe|=n;else{if((n&1073741824)===0)return e=o!==null?o.baseLanes|n:n,t.lanes=t.childLanes=1073741824,t.memoizedState={baseLanes:e,cachePool:null,transitions:null},t.updateQueue=null,ie(Un,Xe),Xe|=e,null;t.memoizedState={baseLanes:0,cachePool:null,transitions:null},r=o!==null?o.baseLanes:n,ie(Un,Xe),Xe|=r}else o!==null?(r=o.baseLanes|n,t.memoizedState=null):r=n,ie(Un,Xe),Xe|=r;return je(e,t,i,n),t.child}function U0(e,t){var n=t.ref;(e===null&&n!==null||e!==null&&e.ref!==n)&&(t.flags|=512,t.flags|=2097152)}function Pa(e,t,n,r,i){var o=Ke(n)?vn:$e.current;return o=Jn(t,o),Kn(t,i),n=Ns(e,t,n,r,o,i),r=Ts(),e!==null&&!Ge?(t.updateQueue=e.updateQueue,t.flags&=-2053,e.lanes&=~i,At(e,t,i)):(ae&&r&&vs(t),t.flags|=1,je(e,t,n,i),t.child)}function e1(e,t,n,r,i){if(Ke(n)){var o=!0;lo(t)}else o=!1;if(Kn(t,i),t.stateNode===null)Hi(e,t),g0(t,n,r),Sa(t,n,r,i),r=!0;else if(e===null){var l=t.stateNode,s=t.memoizedProps;l.props=s;var u=l.context,c=n.contextType;typeof c=="object"&&c!==null?c=ut(c):(c=Ke(n)?vn:$e.current,c=Jn(t,c));var p=n.getDerivedStateFromProps,g=typeof p=="function"||typeof l.getSnapshotBeforeUpdate=="function";g||typeof l.UNSAFE_componentWillReceiveProps!="function"&&typeof l.componentWillReceiveProps!="function"||(s!==r||u!==c)&&Wu(t,l,r,c),Dt=!1;var m=t.memoizedState;l.state=m,fo(t,r,l,i),u=t.memoizedState,s!==r||m!==u||Ye.current||Dt?(typeof p=="function"&&(ka(t,n,p,r),u=t.memoizedState),(s=Dt||Vu(t,n,s,r,m,u,c))?(g||typeof l.UNSAFE_componentWillMount!="function"&&typeof l.componentWillMount!="function"||(typeof l.componentWillMount=="function"&&l.componentWillMount(),typeof l.UNSAFE_componentWillMount=="function"&&l.UNSAFE_componentWillMount()),typeof l.componentDidMount=="function"&&(t.flags|=4194308)):(typeof l.componentDidMount=="function"&&(t.flags|=4194308),t.memoizedProps=r,t.memoizedState=u),l.props=r,l.state=u,l.context=c,r=s):(typeof l.componentDidMount=="function"&&(t.flags|=4194308),r=!1)}else{l=t.stateNode,h0(e,t),s=t.memoizedProps,c=t.type===t.elementType?s:pt(t.type,s),l.props=c,g=t.pendingProps,m=l.context,u=n.contextType,typeof u=="object"&&u!==null?u=ut(u):(u=Ke(n)?vn:$e.current,u=Jn(t,u));var C=n.getDerivedStateFromProps;(p=typeof C=="function"||typeof l.getSnapshotBeforeUpdate=="function")||typeof l.UNSAFE_componentWillReceiveProps!="function"&&typeof l.componentWillReceiveProps!="function"||(s!==g||m!==u)&&Wu(t,l,r,u),Dt=!1,m=t.memoizedState,l.state=m,fo(t,r,l,i);var y=t.memoizedState;s!==g||m!==y||Ye.current||Dt?(typeof C=="function"&&(ka(t,n,C,r),y=t.memoizedState),(c=Dt||Vu(t,n,c,r,m,y,u)||!1)?(p||typeof l.UNSAFE_componentWillUpdate!="function"&&typeof l.componentWillUpdate!="function"||(typeof l.componentWillUpdate=="function"&&l.componentWillUpdate(r,y,u),typeof l.UNSAFE_componentWillUpdate=="function"&&l.UNSAFE_componentWillUpdate(r,y,u)),typeof l.componentDidUpdate=="function"&&(t.flags|=4),typeof l.getSnapshotBeforeUpdate=="function"&&(t.flags|=1024)):(typeof l.componentDidUpdate!="function"||s===e.memoizedProps&&m===e.memoizedState||(t.flags|=4),typeof l.getSnapshotBeforeUpdate!="function"||s===e.memoizedProps&&m===e.memoizedState||(t.flags|=1024),t.memoizedProps=r,t.memoizedState=y),l.props=r,l.state=y,l.context=u,r=c):(typeof l.componentDidUpdate!="function"||s===e.memoizedProps&&m===e.memoizedState||(t.flags|=4),typeof l.getSnapshotBeforeUpdate!="function"||s===e.memoizedProps&&m===e.memoizedState||(t.flags|=1024),r=!1)}return za(e,t,n,r,o,i)}function za(e,t,n,r,i,o){U0(e,t);var l=(t.flags&128)!==0;if(!r&&!l)return i&&ju(t,n,!1),At(e,t,o);r=t.stateNode,u2.current=t;var s=l&&typeof n.getDerivedStateFromError!="function"?null:r.render();return t.flags|=1,e!==null&&l?(t.child=er(t,e.child,null,o),t.child=er(t,null,s,o)):je(e,t,s,o),t.memoizedState=r.state,i&&ju(t,n,!0),t.child}function V0(e){var t=e.stateNode;t.pendingContext?Fu(e,t.pendingContext,t.pendingContext!==t.context):t.context&&Fu(e,t.context,!1),Ps(e,t.containerInfo)}function t1(e,t,n,r,i){return qn(),ws(i),t.flags|=256,je(e,t,n,r),t.child}var Ra={dehydrated:null,treeContext:null,retryLane:0};function La(e){return{baseLanes:e,cachePool:null,transitions:null}}function W0(e,t,n){var r=t.pendingProps,i=se.current,o=!1,l=(t.flags&128)!==0,s;if((s=l)||(s=e!==null&&e.memoizedState===null?!1:(i&2)!==0),s?(o=!0,t.flags&=-129):(e===null||e.memoizedState!==null)&&(i|=1),ie(se,i&1),e===null)return xa(t),e=t.memoizedState,e!==null&&(e=e.dehydrated,e!==null)?((t.mode&1)===0?t.lanes=1:e.data==="$!"?t.lanes=8:t.lanes=1073741824,null):(l=r.children,e=r.fallback,o?(r=t.mode,o=t.child,l={mode:"hidden",children:l},(r&1)===0&&o!==null?(o.childLanes=0,o.pendingProps=l):o=$o(l,r,0,null),e=gn(e,r,n,null),o.return=t,e.return=t,o.sibling=e,t.child=o,t.child.memoizedState=La(n),t.memoizedState=Ra,e):Ms(t,l));if(i=e.memoizedState,i!==null&&(s=i.dehydrated,s!==null))return c2(e,t,l,r,s,i,n);if(o){o=r.fallback,l=t.mode,i=e.child,s=i.sibling;var u={mode:"hidden",children:r.children};return(l&1)===0&&t.child!==i?(r=t.child,r.childLanes=0,r.pendingProps=u,t.deletions=null):(r=qt(i,u),r.subtreeFlags=i.subtreeFlags&14680064),s!==null?o=qt(s,o):(o=gn(o,l,n,null),o.flags|=2),o.return=t,r.return=t,r.sibling=o,t.child=r,r=o,o=t.child,l=e.child.memoizedState,l=l===null?La(n):{baseLanes:l.baseLanes|n,cachePool:null,transitions:l.transitions},o.memoizedState=l,o.childLanes=e.childLanes&~n,t.memoizedState=Ra,r}return o=e.child,e=o.sibling,r=qt(o,{mode:"visible",children:r.children}),(t.mode&1)===0&&(r.lanes=n),r.return=t,r.sibling=null,e!==null&&(n=t.deletions,n===null?(t.deletions=[e],t.flags|=16):n.push(e)),t.child=r,t.memoizedState=null,r}function Ms(e,t){return t=$o({mode:"visible",children:t},e.mode,0,null),t.return=e,e.child=t}function Li(e,t,n,r){return r!==null&&ws(r),er(t,e.child,null,n),e=Ms(t,t.pendingProps.children),e.flags|=2,t.memoizedState=null,e}function c2(e,t,n,r,i,o,l){if(n)return t.flags&256?(t.flags&=-257,r=_l(Error(R(422))),Li(e,t,l,r)):t.memoizedState!==null?(t.child=e.child,t.flags|=128,null):(o=r.fallback,i=t.mode,r=$o({mode:"visible",children:r.children},i,0,null),o=gn(o,i,l,null),o.flags|=2,r.return=t,o.return=t,r.sibling=o,t.child=r,(t.mode&1)!==0&&er(t,e.child,null,l),t.child.memoizedState=La(l),t.memoizedState=Ra,o);if((t.mode&1)===0)return Li(e,t,l,null);if(i.data==="$!"){if(r=i.nextSibling&&i.nextSibling.dataset,r)var s=r.dgst;return r=s,o=Error(R(419)),r=_l(o,r,void 0),Li(e,t,l,r)}if(s=(l&e.childLanes)!==0,Ge||s){if(r=ke,r!==null){switch(l&-l){case 4:i=2;break;case 16:i=8;break;case 64:case 128:case 256:case 512:case 1024:case 2048:case 4096:case 8192:case 16384:case 32768:case 65536:case 131072:case 262144:case 524288:case 1048576:case 2097152:case 4194304:case 8388608:case 16777216:case 33554432:case 67108864:i=32;break;case 536870912:i=268435456;break;default:i=0}i=(i&(r.suspendedLanes|l))!==0?0:i,i!==0&&i!==o.retryLane&&(o.retryLane=i,Ot(e,i),yt(r,e,i,-1))}return js(),r=_l(Error(R(421))),Li(e,t,l,r)}return i.data==="$?"?(t.flags|=128,t.child=e.child,t=S2.bind(null,e),i._reactRetry=t,null):(e=o.treeContext,Je=Kt(i.nextSibling),et=t,ae=!0,mt=null,e!==null&&(ot[lt++]=Nt,ot[lt++]=Tt,ot[lt++]=yn,Nt=e.id,Tt=e.overflow,yn=t),t=Ms(t,r.children),t.flags|=4096,t)}function n1(e,t,n){e.lanes|=t;var r=e.alternate;r!==null&&(r.lanes|=t),Ca(e.return,t,n)}function Ml(e,t,n,r,i){var o=e.memoizedState;o===null?e.memoizedState={isBackwards:t,rendering:null,renderingStartTime:0,last:r,tail:n,tailMode:i}:(o.isBackwards=t,o.rendering=null,o.renderingStartTime=0,o.last=r,o.tail=n,o.tailMode=i)}function G0(e,t,n){var r=t.pendingProps,i=r.revealOrder,o=r.tail;if(je(e,t,r.children,n),r=se.current,(r&2)!==0)r=r&1|2,t.flags|=128;else{if(e!==null&&(e.flags&128)!==0)e:for(e=t.child;e!==null;){if(e.tag===13)e.memoizedState!==null&&n1(e,n,t);else if(e.tag===19)n1(e,n,t);else if(e.child!==null){e.child.return=e,e=e.child;continue}if(e===t)break e;for(;e.sibling===null;){if(e.return===null||e.return===t)break e;e=e.return}e.sibling.return=e.return,e=e.sibling}r&=1}if(ie(se,r),(t.mode&1)===0)t.memoizedState=null;else switch(i){case"forwards":for(n=t.child,i=null;n!==null;)e=n.alternate,e!==null&&po(e)===null&&(i=n),n=n.sibling;n=i,n===null?(i=t.child,t.child=null):(i=n.sibling,n.sibling=null),Ml(t,!1,i,n,o);break;case"backwards":for(n=null,i=t.child,t.child=null;i!==null;){if(e=i.alternate,e!==null&&po(e)===null){t.child=i;break}e=i.sibling,i.sibling=n,n=i,i=e}Ml(t,!0,n,null,o);break;case"together":Ml(t,!1,null,null,void 0);break;default:t.memoizedState=null}return t.child}function Hi(e,t){(t.mode&1)===0&&e!==null&&(e.alternate=null,t.alternate=null,t.flags|=2)}function At(e,t,n){if(e!==null&&(t.dependencies=e.dependencies),xn|=t.lanes,(n&t.childLanes)===0)return null;if(e!==null&&t.child!==e.child)throw Error(R(153));if(t.child!==null){for(e=t.child,n=qt(e,e.pendingProps),t.child=n,n.return=t;e.sibling!==null;)e=e.sibling,n=n.sibling=qt(e,e.pendingProps),n.return=t;n.sibling=null}return t.child}function d2(e,t,n){switch(t.tag){case 3:V0(t),qn();break;case 5:w0(t);break;case 1:Ke(t.type)&&lo(t);break;case 4:Ps(t,t.stateNode.containerInfo);break;case 10:var r=t.type._context,i=t.memoizedProps.value;ie(uo,r._currentValue),r._currentValue=i;break;case 13:if(r=t.memoizedState,r!==null)return r.dehydrated!==null?(ie(se,se.current&1),t.flags|=128,null):(n&t.child.childLanes)!==0?W0(e,t,n):(ie(se,se.current&1),e=At(e,t,n),e!==null?e.sibling:null);ie(se,se.current&1);break;case 19:if(r=(n&t.childLanes)!==0,(e.flags&128)!==0){if(r)return G0(e,t,n);t.flags|=128}if(i=t.memoizedState,i!==null&&(i.rendering=null,i.tail=null,i.lastEffect=null),ie(se,se.current),r)break;return null;case 22:case 23:return t.lanes=0,H0(e,t,n)}return At(e,t,n)}var Q0,Na,Y0,K0;Q0=function(e,t){for(var n=t.child;n!==null;){if(n.tag===5||n.tag===6)e.appendChild(n.stateNode);else if(n.tag!==4&&n.child!==null){n.child.return=n,n=n.child;continue}if(n===t)break;for(;n.sibling===null;){if(n.return===null||n.return===t)return;n=n.return}n.sibling.return=n.return,n=n.sibling}};Na=function(){};Y0=function(e,t,n,r){var i=e.memoizedProps;if(i!==r){e=t.stateNode,hn(Et.current);var o=null;switch(n){case"input":i=Xl(e,i),r=Xl(e,r),o=[];break;case"select":i=ce({},i,{value:void 0}),r=ce({},r,{value:void 0}),o=[];break;case"textarea":i=ea(e,i),r=ea(e,r),o=[];break;default:typeof i.onClick!="function"&&typeof r.onClick=="function"&&(e.onclick=io)}na(n,r);var l;n=null;for(c in i)if(!r.hasOwnProperty(c)&&i.hasOwnProperty(c)&&i[c]!=null)if(c==="style"){var s=i[c];for(l in s)s.hasOwnProperty(l)&&(n||(n={}),n[l]="")}else c!=="dangerouslySetInnerHTML"&&c!=="children"&&c!=="suppressContentEditableWarning"&&c!=="suppressHydrationWarning"&&c!=="autoFocus"&&(jr.hasOwnProperty(c)?o||(o=[]):(o=o||[]).push(c,null));for(c in r){var u=r[c];if(s=i!=null?i[c]:void 0,r.hasOwnProperty(c)&&u!==s&&(u!=null||s!=null))if(c==="style")if(s){for(l in s)!s.hasOwnProperty(l)||u&&u.hasOwnProperty(l)||(n||(n={}),n[l]="");for(l in u)u.hasOwnProperty(l)&&s[l]!==u[l]&&(n||(n={}),n[l]=u[l])}else n||(o||(o=[]),o.push(c,n)),n=u;else c==="dangerouslySetInnerHTML"?(u=u?u.__html:void 0,s=s?s.__html:void 0,u!=null&&s!==u&&(o=o||[]).push(c,u)):c==="children"?typeof u!="string"&&typeof u!="number"||(o=o||[]).push(c,""+u):c!=="suppressContentEditableWarning"&&c!=="suppressHydrationWarning"&&(jr.hasOwnProperty(c)?(u!=null&&c==="onScroll"&&oe("scroll",e),o||s===u||(o=[])):(o=o||[]).push(c,u))}n&&(o=o||[]).push("style",n);var c=o;(t.updateQueue=c)&&(t.flags|=4)}};K0=function(e,t,n,r){n!==r&&(t.flags|=4)};function kr(e,t){if(!ae)switch(e.tailMode){case"hidden":t=e.tail;for(var n=null;t!==null;)t.alternate!==null&&(n=t),t=t.sibling;n===null?e.tail=null:n.sibling=null;break;case"collapsed":n=e.tail;for(var r=null;n!==null;)n.alternate!==null&&(r=n),n=n.sibling;r===null?t||e.tail===null?e.tail=null:e.tail.sibling=null:r.sibling=null}}function Oe(e){var t=e.alternate!==null&&e.alternate.child===e.child,n=0,r=0;if(t)for(var i=e.child;i!==null;)n|=i.lanes|i.childLanes,r|=i.subtreeFlags&14680064,r|=i.flags&14680064,i.return=e,i=i.sibling;else for(i=e.child;i!==null;)n|=i.lanes|i.childLanes,r|=i.subtreeFlags,r|=i.flags,i.return=e,i=i.sibling;return e.subtreeFlags|=r,e.childLanes=n,t}function f2(e,t,n){var r=t.pendingProps;switch(ys(t),t.tag){case 2:case 16:case 15:case 0:case 11:case 7:case 8:case 12:case 9:case 14:return Oe(t),null;case 1:return Ke(t.type)&&oo(),Oe(t),null;case 3:return r=t.stateNode,tr(),le(Ye),le($e),Rs(),r.pendingContext&&(r.context=r.pendingContext,r.pendingContext=null),(e===null||e.child===null)&&(zi(t)?t.flags|=4:e===null||e.memoizedState.isDehydrated&&(t.flags&256)===0||(t.flags|=1024,mt!==null&&(Ia(mt),mt=null))),Na(e,t),Oe(t),null;case 5:zs(t);var i=hn(Xr.current);if(n=t.type,e!==null&&t.stateNode!=null)Y0(e,t,n,r,i),e.ref!==t.ref&&(t.flags|=512,t.flags|=2097152);else{if(!r){if(t.stateNode===null)throw Error(R(166));return Oe(t),null}if(e=hn(Et.current),zi(t)){r=t.stateNode,n=t.type;var o=t.memoizedProps;switch(r[kt]=t,r[Kr]=o,e=(t.mode&1)!==0,n){case"dialog":oe("cancel",r),oe("close",r);break;case"iframe":case"object":case"embed":oe("load",r);break;case"video":case"audio":for(i=0;i<Rr.length;i++)oe(Rr[i],r);break;case"source":oe("error",r);break;case"img":case"image":case"link":oe("error",r),oe("load",r);break;case"details":oe("toggle",r);break;case"input":du(r,o),oe("invalid",r);break;case"select":r._wrapperState={wasMultiple:!!o.multiple},oe("invalid",r);break;case"textarea":pu(r,o),oe("invalid",r)}na(n,o),i=null;for(var l in o)if(o.hasOwnProperty(l)){var s=o[l];l==="children"?typeof s=="string"?r.textContent!==s&&(o.suppressHydrationWarning!==!0&&Pi(r.textContent,s,e),i=["children",s]):typeof s=="number"&&r.textContent!==""+s&&(o.suppressHydrationWarning!==!0&&Pi(r.textContent,s,e),i=["children",""+s]):jr.hasOwnProperty(l)&&s!=null&&l==="onScroll"&&oe("scroll",r)}switch(n){case"input":vi(r),fu(r,o,!0);break;case"textarea":vi(r),hu(r);break;case"select":case"option":break;default:typeof o.onClick=="function"&&(r.onclick=io)}r=i,t.updateQueue=r,r!==null&&(t.flags|=4)}else{l=i.nodeType===9?i:i.ownerDocument,e==="http://www.w3.org/1999/xhtml"&&(e=kc(n)),e==="http://www.w3.org/1999/xhtml"?n==="script"?(e=l.createElement("div"),e.innerHTML="<script><\/script>",e=e.removeChild(e.firstChild)):typeof r.is=="string"?e=l.createElement(n,{is:r.is}):(e=l.createElement(n),n==="select"&&(l=e,r.multiple?l.multiple=!0:r.size&&(l.size=r.size))):e=l.createElementNS(e,n),e[kt]=t,e[Kr]=r,Q0(e,t,!1,!1),t.stateNode=e;e:{switch(l=ra(n,r),n){case"dialog":oe("cancel",e),oe("close",e),i=r;break;case"iframe":case"object":case"embed":oe("load",e),i=r;break;case"video":case"audio":for(i=0;i<Rr.length;i++)oe(Rr[i],e);i=r;break;case"source":oe("error",e),i=r;break;case"img":case"image":case"link":oe("error",e),oe("load",e),i=r;break;case"details":oe("toggle",e),i=r;break;case"input":du(e,r),i=Xl(e,r),oe("invalid",e);break;case"option":i=r;break;case"select":e._wrapperState={wasMultiple:!!r.multiple},i=ce({},r,{value:void 0}),oe("invalid",e);break;case"textarea":pu(e,r),i=ea(e,r),oe("invalid",e);break;default:i=r}na(n,i),s=i;for(o in s)if(s.hasOwnProperty(o)){var u=s[o];o==="style"?Pc(e,u):o==="dangerouslySetInnerHTML"?(u=u?u.__html:void 0,u!=null&&Sc(e,u)):o==="children"?typeof u=="string"?(n!=="textarea"||u!=="")&&Dr(e,u):typeof u=="number"&&Dr(e,""+u):o!=="suppressContentEditableWarning"&&o!=="suppressHydrationWarning"&&o!=="autoFocus"&&(jr.hasOwnProperty(o)?u!=null&&o==="onScroll"&&oe("scroll",e):u!=null&&rs(e,o,u,l))}switch(n){case"input":vi(e),fu(e,r,!1);break;case"textarea":vi(e),hu(e);break;case"option":r.value!=null&&e.setAttribute("value",""+rn(r.value));break;case"select":e.multiple=!!r.multiple,o=r.value,o!=null?Wn(e,!!r.multiple,o,!1):r.defaultValue!=null&&Wn(e,!!r.multiple,r.defaultValue,!0);break;default:typeof i.onClick=="function"&&(e.onclick=io)}switch(n){case"button":case"input":case"select":case"textarea":r=!!r.autoFocus;break e;case"img":r=!0;break e;default:r=!1}}r&&(t.flags|=4)}t.ref!==null&&(t.flags|=512,t.flags|=2097152)}return Oe(t),null;case 6:if(e&&t.stateNode!=null)K0(e,t,e.memoizedProps,r);else{if(typeof r!="string"&&t.stateNode===null)throw Error(R(166));if(n=hn(Xr.current),hn(Et.current),zi(t)){if(r=t.stateNode,n=t.memoizedProps,r[kt]=t,(o=r.nodeValue!==n)&&(e=et,e!==null))switch(e.tag){case 3:Pi(r.nodeValue,n,(e.mode&1)!==0);break;case 5:e.memoizedProps.suppressHydrationWarning!==!0&&Pi(r.nodeValue,n,(e.mode&1)!==0)}o&&(t.flags|=4)}else r=(n.nodeType===9?n:n.ownerDocument).createTextNode(r),r[kt]=t,t.stateNode=r}return Oe(t),null;case 13:if(le(se),r=t.memoizedState,e===null||e.memoizedState!==null&&e.memoizedState.dehydrated!==null){if(ae&&Je!==null&&(t.mode&1)!==0&&(t.flags&128)===0)f0(),qn(),t.flags|=98560,o=!1;else if(o=zi(t),r!==null&&r.dehydrated!==null){if(e===null){if(!o)throw Error(R(318));if(o=t.memoizedState,o=o!==null?o.dehydrated:null,!o)throw Error(R(317));o[kt]=t}else qn(),(t.flags&128)===0&&(t.memoizedState=null),t.flags|=4;Oe(t),o=!1}else mt!==null&&(Ia(mt),mt=null),o=!0;if(!o)return t.flags&65536?t:null}return(t.flags&128)!==0?(t.lanes=n,t):(r=r!==null,r!==(e!==null&&e.memoizedState!==null)&&r&&(t.child.flags|=8192,(t.mode&1)!==0&&(e===null||(se.current&1)!==0?xe===0&&(xe=3):js())),t.updateQueue!==null&&(t.flags|=4),Oe(t),null);case 4:return tr(),Na(e,t),e===null&&Qr(t.stateNode.containerInfo),Oe(t),null;case 10:return ks(t.type._context),Oe(t),null;case 17:return Ke(t.type)&&oo(),Oe(t),null;case 19:if(le(se),o=t.memoizedState,o===null)return Oe(t),null;if(r=(t.flags&128)!==0,l=o.rendering,l===null)if(r)kr(o,!1);else{if(xe!==0||e!==null&&(e.flags&128)!==0)for(e=t.child;e!==null;){if(l=po(e),l!==null){for(t.flags|=128,kr(o,!1),r=l.updateQueue,r!==null&&(t.updateQueue=r,t.flags|=4),t.subtreeFlags=0,r=n,n=t.child;n!==null;)o=n,e=r,o.flags&=14680066,l=o.alternate,l===null?(o.childLanes=0,o.lanes=e,o.child=null,o.subtreeFlags=0,o.memoizedProps=null,o.memoizedState=null,o.updateQueue=null,o.dependencies=null,o.stateNode=null):(o.childLanes=l.childLanes,o.lanes=l.lanes,o.child=l.child,o.subtreeFlags=0,o.deletions=null,o.memoizedProps=l.memoizedProps,o.memoizedState=l.memoizedState,o.updateQueue=l.updateQueue,o.type=l.type,e=l.dependencies,o.dependencies=e===null?null:{lanes:e.lanes,firstContext:e.firstContext}),n=n.sibling;return ie(se,se.current&1|2),t.child}e=e.sibling}o.tail!==null&&he()>rr&&(t.flags|=128,r=!0,kr(o,!1),t.lanes=4194304)}else{if(!r)if(e=po(l),e!==null){if(t.flags|=128,r=!0,n=e.updateQueue,n!==null&&(t.updateQueue=n,t.flags|=4),kr(o,!0),o.tail===null&&o.tailMode==="hidden"&&!l.alternate&&!ae)return Oe(t),null}else 2*he()-o.renderingStartTime>rr&&n!==1073741824&&(t.flags|=128,r=!0,kr(o,!1),t.lanes=4194304);o.isBackwards?(l.sibling=t.child,t.child=l):(n=o.last,n!==null?n.sibling=l:t.child=l,o.last=l)}return o.tail!==null?(t=o.tail,o.rendering=t,o.tail=t.sibling,o.renderingStartTime=he(),t.sibling=null,n=se.current,ie(se,r?n&1|2:n&1),t):(Oe(t),null);case 22:case 23:return Fs(),r=t.memoizedState!==null,e!==null&&e.memoizedState!==null!==r&&(t.flags|=8192),r&&(t.mode&1)!==0?(Xe&1073741824)!==0&&(Oe(t),t.subtreeFlags&6&&(t.flags|=8192)):Oe(t),null;case 24:return null;case 25:return null}throw Error(R(156,t.tag))}function p2(e,t){switch(ys(t),t.tag){case 1:return Ke(t.type)&&oo(),e=t.flags,e&65536?(t.flags=e&-65537|128,t):null;case 3:return tr(),le(Ye),le($e),Rs(),e=t.flags,(e&65536)!==0&&(e&128)===0?(t.flags=e&-65537|128,t):null;case 5:return zs(t),null;case 13:if(le(se),e=t.memoizedState,e!==null&&e.dehydrated!==null){if(t.alternate===null)throw Error(R(340));qn()}return e=t.flags,e&65536?(t.flags=e&-65537|128,t):null;case 19:return le(se),null;case 4:return tr(),null;case 10:return ks(t.type._context),null;case 22:case 23:return Fs(),null;case 24:return null;default:return null}}var Ni=!1,Ae=!1,h2=typeof WeakSet=="function"?WeakSet:Set,$=null;function Hn(e,t){var n=e.ref;if(n!==null)if(typeof n=="function")try{n(null)}catch(r){fe(e,t,r)}else n.current=null}function Ta(e,t,n){try{n()}catch(r){fe(e,t,r)}}var r1=!1;function m2(e,t){if(pa=to,e=qc(),gs(e)){if("selectionStart"in e)var n={start:e.selectionStart,end:e.selectionEnd};else e:{n=(n=e.ownerDocument)&&n.defaultView||window;var r=n.getSelection&&n.getSelection();if(r&&r.rangeCount!==0){n=r.anchorNode;var i=r.anchorOffset,o=r.focusNode;r=r.focusOffset;try{n.nodeType,o.nodeType}catch{n=null;break e}var l=0,s=-1,u=-1,c=0,p=0,g=e,m=null;t:for(;;){for(var C;g!==n||i!==0&&g.nodeType!==3||(s=l+i),g!==o||r!==0&&g.nodeType!==3||(u=l+r),g.nodeType===3&&(l+=g.nodeValue.length),(C=g.firstChild)!==null;)m=g,g=C;for(;;){if(g===e)break t;if(m===n&&++c===i&&(s=l),m===o&&++p===r&&(u=l),(C=g.nextSibling)!==null)break;g=m,m=g.parentNode}g=C}n=s===-1||u===-1?null:{start:s,end:u}}else n=null}n=n||{start:0,end:0}}else n=null;for(ha={focusedElem:e,selectionRange:n},to=!1,$=t;$!==null;)if(t=$,e=t.child,(t.subtreeFlags&1028)!==0&&e!==null)e.return=t,$=e;else for(;$!==null;){t=$;try{var y=t.alternate;if((t.flags&1024)!==0)switch(t.tag){case 0:case 11:case 15:break;case 1:if(y!==null){var w=y.memoizedProps,P=y.memoizedState,f=t.stateNode,d=f.getSnapshotBeforeUpdate(t.elementType===t.type?w:pt(t.type,w),P);f.__reactInternalSnapshotBeforeUpdate=d}break;case 3:var h=t.stateNode.containerInfo;h.nodeType===1?h.textContent="":h.nodeType===9&&h.documentElement&&h.removeChild(h.documentElement);break;case 5:case 6:case 4:case 17:break;default:throw Error(R(163))}}catch(k){fe(t,t.return,k)}if(e=t.sibling,e!==null){e.return=t.return,$=e;break}$=t.return}return y=r1,r1=!1,y}function Ar(e,t,n){var r=t.updateQueue;if(r=r!==null?r.lastEffect:null,r!==null){var i=r=r.next;do{if((i.tag&e)===e){var o=i.destroy;i.destroy=void 0,o!==void 0&&Ta(t,n,o)}i=i.next}while(i!==r)}}function Oo(e,t){if(t=t.updateQueue,t=t!==null?t.lastEffect:null,t!==null){var n=t=t.next;do{if((n.tag&e)===e){var r=n.create;n.destroy=r()}n=n.next}while(n!==t)}}function ba(e){var t=e.ref;if(t!==null){var n=e.stateNode;switch(e.tag){case 5:e=n;break;default:e=n}typeof t=="function"?t(e):t.current=e}}function Z0(e){var t=e.alternate;t!==null&&(e.alternate=null,Z0(t)),e.child=null,e.deletions=null,e.sibling=null,e.tag===5&&(t=e.stateNode,t!==null&&(delete t[kt],delete t[Kr],delete t[va],delete t[X5],delete t[J5])),e.stateNode=null,e.return=null,e.dependencies=null,e.memoizedProps=null,e.memoizedState=null,e.pendingProps=null,e.stateNode=null,e.updateQueue=null}function X0(e){return e.tag===5||e.tag===3||e.tag===4}function i1(e){e:for(;;){for(;e.sibling===null;){if(e.return===null||X0(e.return))return null;e=e.return}for(e.sibling.return=e.return,e=e.sibling;e.tag!==5&&e.tag!==6&&e.tag!==18;){if(e.flags&2||e.child===null||e.tag===4)continue e;e.child.return=e,e=e.child}if(!(e.flags&2))return e.stateNode}}function _a(e,t,n){var r=e.tag;if(r===5||r===6)e=e.stateNode,t?n.nodeType===8?n.parentNode.insertBefore(e,t):n.insertBefore(e,t):(n.nodeType===8?(t=n.parentNode,t.insertBefore(e,n)):(t=n,t.appendChild(e)),n=n._reactRootContainer,n!=null||t.onclick!==null||(t.onclick=io));else if(r!==4&&(e=e.child,e!==null))for(_a(e,t,n),e=e.sibling;e!==null;)_a(e,t,n),e=e.sibling}function Ma(e,t,n){var r=e.tag;if(r===5||r===6)e=e.stateNode,t?n.insertBefore(e,t):n.appendChild(e);else if(r!==4&&(e=e.child,e!==null))for(Ma(e,t,n),e=e.sibling;e!==null;)Ma(e,t,n),e=e.sibling}var Le=null,ht=!1;function Ft(e,t,n){for(n=n.child;n!==null;)J0(e,t,n),n=n.sibling}function J0(e,t,n){if(St&&typeof St.onCommitFiberUnmount=="function")try{St.onCommitFiberUnmount(zo,n)}catch{}switch(n.tag){case 5:Ae||Hn(n,t);case 6:var r=Le,i=ht;Le=null,Ft(e,t,n),Le=r,ht=i,Le!==null&&(ht?(e=Le,n=n.stateNode,e.nodeType===8?e.parentNode.removeChild(n):e.removeChild(n)):Le.removeChild(n.stateNode));break;case 18:Le!==null&&(ht?(e=Le,n=n.stateNode,e.nodeType===8?zl(e.parentNode,n):e.nodeType===1&&zl(e,n),Vr(e)):zl(Le,n.stateNode));break;case 4:r=Le,i=ht,Le=n.stateNode.containerInfo,ht=!0,Ft(e,t,n),Le=r,ht=i;break;case 0:case 11:case 14:case 15:if(!Ae&&(r=n.updateQueue,r!==null&&(r=r.lastEffect,r!==null))){i=r=r.next;do{var o=i,l=o.destroy;o=o.tag,l!==void 0&&((o&2)!==0||(o&4)!==0)&&Ta(n,t,l),i=i.next}while(i!==r)}Ft(e,t,n);break;case 1:if(!Ae&&(Hn(n,t),r=n.stateNode,typeof r.componentWillUnmount=="function"))try{r.props=n.memoizedProps,r.state=n.memoizedState,r.componentWillUnmount()}catch(s){fe(n,t,s)}Ft(e,t,n);break;case 21:Ft(e,t,n);break;case 22:n.mode&1?(Ae=(r=Ae)||n.memoizedState!==null,Ft(e,t,n),Ae=r):Ft(e,t,n);break;default:Ft(e,t,n)}}function o1(e){var t=e.updateQueue;if(t!==null){e.updateQueue=null;var n=e.stateNode;n===null&&(n=e.stateNode=new h2),t.forEach(function(r){var i=E2.bind(null,e,r);n.has(r)||(n.add(r),r.then(i,i))})}}function ft(e,t){var n=t.deletions;if(n!==null)for(var r=0;r<n.length;r++){var i=n[r];try{var o=e,l=t,s=l;e:for(;s!==null;){switch(s.tag){case 5:Le=s.stateNode,ht=!1;break e;case 3:Le=s.stateNode.containerInfo,ht=!0;break e;case 4:Le=s.stateNode.containerInfo,ht=!0;break e}s=s.return}if(Le===null)throw Error(R(160));J0(o,l,i),Le=null,ht=!1;var u=i.alternate;u!==null&&(u.return=null),i.return=null}catch(c){fe(i,t,c)}}if(t.subtreeFlags&12854)for(t=t.child;t!==null;)q0(t,e),t=t.sibling}function q0(e,t){var n=e.alternate,r=e.flags;switch(e.tag){case 0:case 11:case 14:case 15:if(ft(t,e),xt(e),r&4){try{Ar(3,e,e.return),Oo(3,e)}catch(w){fe(e,e.return,w)}try{Ar(5,e,e.return)}catch(w){fe(e,e.return,w)}}break;case 1:ft(t,e),xt(e),r&512&&n!==null&&Hn(n,n.return);break;case 5:if(ft(t,e),xt(e),r&512&&n!==null&&Hn(n,n.return),e.flags&32){var i=e.stateNode;try{Dr(i,"")}catch(w){fe(e,e.return,w)}}if(r&4&&(i=e.stateNode,i!=null)){var o=e.memoizedProps,l=n!==null?n.memoizedProps:o,s=e.type,u=e.updateQueue;if(e.updateQueue=null,u!==null)try{s==="input"&&o.type==="radio"&&o.name!=null&&xc(i,o),ra(s,l);var c=ra(s,o);for(l=0;l<u.length;l+=2){var p=u[l],g=u[l+1];p==="style"?Pc(i,g):p==="dangerouslySetInnerHTML"?Sc(i,g):p==="children"?Dr(i,g):rs(i,p,g,c)}switch(s){case"input":Jl(i,o);break;case"textarea":Cc(i,o);break;case"select":var m=i._wrapperState.wasMultiple;i._wrapperState.wasMultiple=!!o.multiple;var C=o.value;C!=null?Wn(i,!!o.multiple,C,!1):m!==!!o.multiple&&(o.defaultValue!=null?Wn(i,!!o.multiple,o.defaultValue,!0):Wn(i,!!o.multiple,o.multiple?[]:"",!1))}i[Kr]=o}catch(w){fe(e,e.return,w)}}break;case 6:if(ft(t,e),xt(e),r&4){if(e.stateNode===null)throw Error(R(162));i=e.stateNode,o=e.memoizedProps;try{i.nodeValue=o}catch(w){fe(e,e.return,w)}}break;case 3:if(ft(t,e),xt(e),r&4&&n!==null&&n.memoizedState.isDehydrated)try{Vr(t.containerInfo)}catch(w){fe(e,e.return,w)}break;case 4:ft(t,e),xt(e);break;case 13:ft(t,e),xt(e),i=e.child,i.flags&8192&&(o=i.memoizedState!==null,i.stateNode.isHidden=o,!o||i.alternate!==null&&i.alternate.memoizedState!==null||($s=he())),r&4&&o1(e);break;case 22:if(p=n!==null&&n.memoizedState!==null,e.mode&1?(Ae=(c=Ae)||p,ft(t,e),Ae=c):ft(t,e),xt(e),r&8192){if(c=e.memoizedState!==null,(e.stateNode.isHidden=c)&&!p&&(e.mode&1)!==0)for($=e,p=e.child;p!==null;){for(g=$=p;$!==null;){switch(m=$,C=m.child,m.tag){case 0:case 11:case 14:case 15:Ar(4,m,m.return);break;case 1:Hn(m,m.return);var y=m.stateNode;if(typeof y.componentWillUnmount=="function"){r=m,n=m.return;try{t=r,y.props=t.memoizedProps,y.state=t.memoizedState,y.componentWillUnmount()}catch(w){fe(r,n,w)}}break;case 5:Hn(m,m.return);break;case 22:if(m.memoizedState!==null){a1(g);continue}}C!==null?(C.return=m,$=C):a1(g)}p=p.sibling}e:for(p=null,g=e;;){if(g.tag===5){if(p===null){p=g;try{i=g.stateNode,c?(o=i.style,typeof o.setProperty=="function"?o.setProperty("display","none","important"):o.display="none"):(s=g.stateNode,u=g.memoizedProps.style,l=u!=null&&u.hasOwnProperty("display")?u.display:null,s.style.display=Ec("display",l))}catch(w){fe(e,e.return,w)}}}else if(g.tag===6){if(p===null)try{g.stateNode.nodeValue=c?"":g.memoizedProps}catch(w){fe(e,e.return,w)}}else if((g.tag!==22&&g.tag!==23||g.memoizedState===null||g===e)&&g.child!==null){g.child.return=g,g=g.child;continue}if(g===e)break e;for(;g.sibling===null;){if(g.return===null||g.return===e)break e;p===g&&(p=null),g=g.return}p===g&&(p=null),g.sibling.return=g.return,g=g.sibling}}break;case 19:ft(t,e),xt(e),r&4&&o1(e);break;case 21:break;default:ft(t,e),xt(e)}}function xt(e){var t=e.flags;if(t&2){try{e:{for(var n=e.return;n!==null;){if(X0(n)){var r=n;break e}n=n.return}throw Error(R(160))}switch(r.tag){case 5:var i=r.stateNode;r.flags&32&&(Dr(i,""),r.flags&=-33);var o=i1(e);Ma(e,o,i);break;case 3:case 4:var l=r.stateNode.containerInfo,s=i1(e);_a(e,s,l);break;default:throw Error(R(161))}}catch(u){fe(e,e.return,u)}e.flags&=-3}t&4096&&(e.flags&=-4097)}function g2(e,t,n){$=e,ed(e)}function ed(e,t,n){for(var r=(e.mode&1)!==0;$!==null;){var i=$,o=i.child;if(i.tag===22&&r){var l=i.memoizedState!==null||Ni;if(!l){var s=i.alternate,u=s!==null&&s.memoizedState!==null||Ae;s=Ni;var c=Ae;if(Ni=l,(Ae=u)&&!c)for($=i;$!==null;)l=$,u=l.child,l.tag===22&&l.memoizedState!==null?s1(i):u!==null?(u.return=l,$=u):s1(i);for(;o!==null;)$=o,ed(o),o=o.sibling;$=i,Ni=s,Ae=c}l1(e)}else(i.subtreeFlags&8772)!==0&&o!==null?(o.return=i,$=o):l1(e)}}function l1(e){for(;$!==null;){var t=$;if((t.flags&8772)!==0){var n=t.alternate;try{if((t.flags&8772)!==0)switch(t.tag){case 0:case 11:case 15:Ae||Oo(5,t);break;case 1:var r=t.stateNode;if(t.flags&4&&!Ae)if(n===null)r.componentDidMount();else{var i=t.elementType===t.type?n.memoizedProps:pt(t.type,n.memoizedProps);r.componentDidUpdate(i,n.memoizedState,r.__reactInternalSnapshotBeforeUpdate)}var o=t.updateQueue;o!==null&&Uu(t,o,r);break;case 3:var l=t.updateQueue;if(l!==null){if(n=null,t.child!==null)switch(t.child.tag){case 5:n=t.child.stateNode;break;case 1:n=t.child.stateNode}Uu(t,l,n)}break;case 5:var s=t.stateNode;if(n===null&&t.flags&4){n=s;var u=t.memoizedProps;switch(t.type){case"button":case"input":case"select":case"textarea":u.autoFocus&&n.focus();break;case"img":u.src&&(n.src=u.src)}}break;case 6:break;case 4:break;case 12:break;case 13:if(t.memoizedState===null){var c=t.alternate;if(c!==null){var p=c.memoizedState;if(p!==null){var g=p.dehydrated;g!==null&&Vr(g)}}}break;case 19:case 17:case 21:case 22:case 23:case 25:break;default:throw Error(R(163))}Ae||t.flags&512&&ba(t)}catch(m){fe(t,t.return,m)}}if(t===e){$=null;break}if(n=t.sibling,n!==null){n.return=t.return,$=n;break}$=t.return}}function a1(e){for(;$!==null;){var t=$;if(t===e){$=null;break}var n=t.sibling;if(n!==null){n.return=t.return,$=n;break}$=t.return}}function s1(e){for(;$!==null;){var t=$;try{switch(t.tag){case 0:case 11:case 15:var n=t.return;try{Oo(4,t)}catch(u){fe(t,n,u)}break;case 1:var r=t.stateNode;if(typeof r.componentDidMount=="function"){var i=t.return;try{r.componentDidMount()}catch(u){fe(t,i,u)}}var o=t.return;try{ba(t)}catch(u){fe(t,o,u)}break;case 5:var l=t.return;try{ba(t)}catch(u){fe(t,l,u)}}}catch(u){fe(t,t.return,u)}if(t===e){$=null;break}var s=t.sibling;if(s!==null){s.return=t.return,$=s;break}$=t.return}}var v2=Math.ceil,go=$t.ReactCurrentDispatcher,Os=$t.ReactCurrentOwner,st=$t.ReactCurrentBatchConfig,K=0,ke=null,ge=null,Ne=0,Xe=0,Un=an(0),xe=0,ti=null,xn=0,Ao=0,As=0,$r=null,Ve=null,$s=0,rr=1/0,Rt=null,vo=!1,Oa=null,Xt=null,Ti=!1,Vt=null,yo=0,Ir=0,Aa=null,Ui=-1,Vi=0;function De(){return(K&6)!==0?he():Ui!==-1?Ui:Ui=he()}function Jt(e){return(e.mode&1)===0?1:(K&2)!==0&&Ne!==0?Ne&-Ne:e2.transition!==null?(Vi===0&&(Vi=Ic()),Vi):(e=ee,e!==0||(e=window.event,e=e===void 0?16:Vc(e.type)),e)}function yt(e,t,n,r){if(50<Ir)throw Ir=0,Aa=null,Error(R(185));li(e,n,r),((K&2)===0||e!==ke)&&(e===ke&&((K&2)===0&&(Ao|=n),xe===4&&Ht(e,Ne)),Ze(e,r),n===1&&K===0&&(t.mode&1)===0&&(rr=he()+500,bo&&sn()))}function Ze(e,t){var n=e.callbackNode;e5(e,t);var r=eo(e,e===ke?Ne:0);if(r===0)n!==null&&vu(n),e.callbackNode=null,e.callbackPriority=0;else if(t=r&-r,e.callbackPriority!==t){if(n!=null&&vu(n),t===1)e.tag===0?q5(u1.bind(null,e)):u0(u1.bind(null,e)),K5(function(){(K&6)===0&&sn()}),n=null;else{switch(Fc(r)){case 1:n=ss;break;case 4:n=Ac;break;case 16:n=qi;break;case 536870912:n=$c;break;default:n=qi}n=sd(n,td.bind(null,e))}e.callbackPriority=t,e.callbackNode=n}}function td(e,t){if(Ui=-1,Vi=0,(K&6)!==0)throw Error(R(327));var n=e.callbackNode;if(Zn()&&e.callbackNode!==n)return null;var r=eo(e,e===ke?Ne:0);if(r===0)return null;if((r&30)!==0||(r&e.expiredLanes)!==0||t)t=wo(e,r);else{t=r;var i=K;K|=2;var o=rd();(ke!==e||Ne!==t)&&(Rt=null,rr=he()+500,mn(e,t));do try{x2();break}catch(s){nd(e,s)}while(1);Cs(),go.current=o,K=i,ge!==null?t=0:(ke=null,Ne=0,t=xe)}if(t!==0){if(t===2&&(i=sa(e),i!==0&&(r=i,t=$a(e,i))),t===1)throw n=ti,mn(e,0),Ht(e,r),Ze(e,he()),n;if(t===6)Ht(e,r);else{if(i=e.current.alternate,(r&30)===0&&!y2(i)&&(t=wo(e,r),t===2&&(o=sa(e),o!==0&&(r=o,t=$a(e,o))),t===1))throw n=ti,mn(e,0),Ht(e,r),Ze(e,he()),n;switch(e.finishedWork=i,e.finishedLanes=r,t){case 0:case 1:throw Error(R(345));case 2:dn(e,Ve,Rt);break;case 3:if(Ht(e,r),(r&130023424)===r&&(t=$s+500-he(),10<t)){if(eo(e,0)!==0)break;if(i=e.suspendedLanes,(i&r)!==r){De(),e.pingedLanes|=e.suspendedLanes&i;break}e.timeoutHandle=ga(dn.bind(null,e,Ve,Rt),t);break}dn(e,Ve,Rt);break;case 4:if(Ht(e,r),(r&4194240)===r)break;for(t=e.eventTimes,i=-1;0<r;){var l=31-vt(r);o=1<<l,l=t[l],l>i&&(i=l),r&=~o}if(r=i,r=he()-r,r=(120>r?120:480>r?480:1080>r?1080:1920>r?1920:3e3>r?3e3:4320>r?4320:1960*v2(r/1960))-r,10<r){e.timeoutHandle=ga(dn.bind(null,e,Ve,Rt),r);break}dn(e,Ve,Rt);break;case 5:dn(e,Ve,Rt);break;default:throw Error(R(329))}}}return Ze(e,he()),e.callbackNode===n?td.bind(null,e):null}function $a(e,t){var n=$r;return e.current.memoizedState.isDehydrated&&(mn(e,t).flags|=256),e=wo(e,t),e!==2&&(t=Ve,Ve=n,t!==null&&Ia(t)),e}function Ia(e){Ve===null?Ve=e:Ve.push.apply(Ve,e)}function y2(e){for(var t=e;;){if(t.flags&16384){var n=t.updateQueue;if(n!==null&&(n=n.stores,n!==null))for(var r=0;r<n.length;r++){var i=n[r],o=i.getSnapshot;i=i.value;try{if(!wt(o(),i))return!1}catch{return!1}}}if(n=t.child,t.subtreeFlags&16384&&n!==null)n.return=t,t=n;else{if(t===e)break;for(;t.sibling===null;){if(t.return===null||t.return===e)return!0;t=t.return}t.sibling.return=t.return,t=t.sibling}}return!0}function Ht(e,t){for(t&=~As,t&=~Ao,e.suspendedLanes|=t,e.pingedLanes&=~t,e=e.expirationTimes;0<t;){var n=31-vt(t),r=1<<n;e[n]=-1,t&=~r}}function u1(e){if((K&6)!==0)throw Error(R(327));Zn();var t=eo(e,0);if((t&1)===0)return Ze(e,he()),null;var n=wo(e,t);if(e.tag!==0&&n===2){var r=sa(e);r!==0&&(t=r,n=$a(e,r))}if(n===1)throw n=ti,mn(e,0),Ht(e,t),Ze(e,he()),n;if(n===6)throw Error(R(345));return e.finishedWork=e.current.alternate,e.finishedLanes=t,dn(e,Ve,Rt),Ze(e,he()),null}function Is(e,t){var n=K;K|=1;try{return e(t)}finally{K=n,K===0&&(rr=he()+500,bo&&sn())}}function Cn(e){Vt!==null&&Vt.tag===0&&(K&6)===0&&Zn();var t=K;K|=1;var n=st.transition,r=ee;try{if(st.transition=null,ee=1,e)return e()}finally{ee=r,st.transition=n,K=t,(K&6)===0&&sn()}}function Fs(){Xe=Un.current,le(Un)}function mn(e,t){e.finishedWork=null,e.finishedLanes=0;var n=e.timeoutHandle;if(n!==-1&&(e.timeoutHandle=-1,Y5(n)),ge!==null)for(n=ge.return;n!==null;){var r=n;switch(ys(r),r.tag){case 1:r=r.type.childContextTypes,r!=null&&oo();break;case 3:tr(),le(Ye),le($e),Rs();break;case 5:zs(r);break;case 4:tr();break;case 13:le(se);break;case 19:le(se);break;case 10:ks(r.type._context);break;case 22:case 23:Fs()}n=n.return}if(ke=e,ge=e=qt(e.current,null),Ne=Xe=t,xe=0,ti=null,As=Ao=xn=0,Ve=$r=null,pn!==null){for(t=0;t<pn.length;t++)if(n=pn[t],r=n.interleaved,r!==null){n.interleaved=null;var i=r.next,o=n.pending;if(o!==null){var l=o.next;o.next=i,r.next=l}n.pending=r}pn=null}return e}function nd(e,t){do{var n=ge;try{if(Cs(),Di.current=mo,ho){for(var r=ue.memoizedState;r!==null;){var i=r.queue;i!==null&&(i.pending=null),r=r.next}ho=!1}if(wn=0,Ce=ye=ue=null,Or=!1,Jr=0,Os.current=null,n===null||n.return===null){xe=1,ti=t,ge=null;break}e:{var o=e,l=n.return,s=n,u=t;if(t=Ne,s.flags|=32768,u!==null&&typeof u=="object"&&typeof u.then=="function"){var c=u,p=s,g=p.tag;if((p.mode&1)===0&&(g===0||g===11||g===15)){var m=p.alternate;m?(p.updateQueue=m.updateQueue,p.memoizedState=m.memoizedState,p.lanes=m.lanes):(p.updateQueue=null,p.memoizedState=null)}var C=Zu(l);if(C!==null){C.flags&=-257,Xu(C,l,s,o,t),C.mode&1&&Ku(o,c,t),t=C,u=c;var y=t.updateQueue;if(y===null){var w=new Set;w.add(u),t.updateQueue=w}else y.add(u);break e}else{if((t&1)===0){Ku(o,c,t),js();break e}u=Error(R(426))}}else if(ae&&s.mode&1){var P=Zu(l);if(P!==null){(P.flags&65536)===0&&(P.flags|=256),Xu(P,l,s,o,t),ws(nr(u,s));break e}}o=u=nr(u,s),xe!==4&&(xe=2),$r===null?$r=[o]:$r.push(o),o=l;do{switch(o.tag){case 3:o.flags|=65536,t&=-t,o.lanes|=t;var f=j0(o,u,t);Hu(o,f);break e;case 1:s=u;var d=o.type,h=o.stateNode;if((o.flags&128)===0&&(typeof d.getDerivedStateFromError=="function"||h!==null&&typeof h.componentDidCatch=="function"&&(Xt===null||!Xt.has(h)))){o.flags|=65536,t&=-t,o.lanes|=t;var k=D0(o,s,t);Hu(o,k);break e}}o=o.return}while(o!==null)}od(n)}catch(z){t=z,ge===n&&n!==null&&(ge=n=n.return);continue}break}while(1)}function rd(){var e=go.current;return go.current=mo,e===null?mo:e}function js(){(xe===0||xe===3||xe===2)&&(xe=4),ke===null||(xn&268435455)===0&&(Ao&268435455)===0||Ht(ke,Ne)}function wo(e,t){var n=K;K|=2;var r=rd();(ke!==e||Ne!==t)&&(Rt=null,mn(e,t));do try{w2();break}catch(i){nd(e,i)}while(1);if(Cs(),K=n,go.current=r,ge!==null)throw Error(R(261));return ke=null,Ne=0,xe}function w2(){for(;ge!==null;)id(ge)}function x2(){for(;ge!==null&&!Wf();)id(ge)}function id(e){var t=ad(e.alternate,e,Xe);e.memoizedProps=e.pendingProps,t===null?od(e):ge=t,Os.current=null}function od(e){var t=e;do{var n=t.alternate;if(e=t.return,(t.flags&32768)===0){if(n=f2(n,t,Xe),n!==null){ge=n;return}}else{if(n=p2(n,t),n!==null){n.flags&=32767,ge=n;return}if(e!==null)e.flags|=32768,e.subtreeFlags=0,e.deletions=null;else{xe=6,ge=null;return}}if(t=t.sibling,t!==null){ge=t;return}ge=t=e}while(t!==null);xe===0&&(xe=5)}function dn(e,t,n){var r=ee,i=st.transition;try{st.transition=null,ee=1,C2(e,t,n,r)}finally{st.transition=i,ee=r}return null}function C2(e,t,n,r){do Zn();while(Vt!==null);if((K&6)!==0)throw Error(R(327));n=e.finishedWork;var i=e.finishedLanes;if(n===null)return null;if(e.finishedWork=null,e.finishedLanes=0,n===e.current)throw Error(R(177));e.callbackNode=null,e.callbackPriority=0;var o=n.lanes|n.childLanes;if(t5(e,o),e===ke&&(ge=ke=null,Ne=0),(n.subtreeFlags&2064)===0&&(n.flags&2064)===0||Ti||(Ti=!0,sd(qi,function(){return Zn(),null})),o=(n.flags&15990)!==0,(n.subtreeFlags&15990)!==0||o){o=st.transition,st.transition=null;var l=ee;ee=1;var s=K;K|=4,Os.current=null,m2(e,n),q0(n,e),B5(ha),to=!!pa,ha=pa=null,e.current=n,g2(n),Gf(),K=s,ee=l,st.transition=o}else e.current=n;if(Ti&&(Ti=!1,Vt=e,yo=i),o=e.pendingLanes,o===0&&(Xt=null),Kf(n.stateNode),Ze(e,he()),t!==null)for(r=e.onRecoverableError,n=0;n<t.length;n++)i=t[n],r(i.value,{componentStack:i.stack,digest:i.digest});if(vo)throw vo=!1,e=Oa,Oa=null,e;return(yo&1)!==0&&e.tag!==0&&Zn(),o=e.pendingLanes,(o&1)!==0?e===Aa?Ir++:(Ir=0,Aa=e):Ir=0,sn(),null}function Zn(){if(Vt!==null){var e=Fc(yo),t=st.transition,n=ee;try{if(st.transition=null,ee=16>e?16:e,Vt===null)var r=!1;else{if(e=Vt,Vt=null,yo=0,(K&6)!==0)throw Error(R(331));var i=K;for(K|=4,$=e.current;$!==null;){var o=$,l=o.child;if(($.flags&16)!==0){var s=o.deletions;if(s!==null){for(var u=0;u<s.length;u++){var c=s[u];for($=c;$!==null;){var p=$;switch(p.tag){case 0:case 11:case 15:Ar(8,p,o)}var g=p.child;if(g!==null)g.return=p,$=g;else for(;$!==null;){p=$;var m=p.sibling,C=p.return;if(Z0(p),p===c){$=null;break}if(m!==null){m.return=C,$=m;break}$=C}}}var y=o.alternate;if(y!==null){var w=y.child;if(w!==null){y.child=null;do{var P=w.sibling;w.sibling=null,w=P}while(w!==null)}}$=o}}if((o.subtreeFlags&2064)!==0&&l!==null)l.return=o,$=l;else e:for(;$!==null;){if(o=$,(o.flags&2048)!==0)switch(o.tag){case 0:case 11:case 15:Ar(9,o,o.return)}var f=o.sibling;if(f!==null){f.return=o.return,$=f;break e}$=o.return}}var d=e.current;for($=d;$!==null;){l=$;var h=l.child;if((l.subtreeFlags&2064)!==0&&h!==null)h.return=l,$=h;else e:for(l=d;$!==null;){if(s=$,(s.flags&2048)!==0)try{switch(s.tag){case 0:case 11:case 15:Oo(9,s)}}catch(z){fe(s,s.return,z)}if(s===l){$=null;break e}var k=s.sibling;if(k!==null){k.return=s.return,$=k;break e}$=s.return}}if(K=i,sn(),St&&typeof St.onPostCommitFiberRoot=="function")try{St.onPostCommitFiberRoot(zo,e)}catch{}r=!0}return r}finally{ee=n,st.transition=t}}return!1}function c1(e,t,n){t=nr(n,t),t=j0(e,t,1),e=Zt(e,t,1),t=De(),e!==null&&(li(e,1,t),Ze(e,t))}function fe(e,t,n){if(e.tag===3)c1(e,e,n);else for(;t!==null;){if(t.tag===3){c1(t,e,n);break}else if(t.tag===1){var r=t.stateNode;if(typeof t.type.getDerivedStateFromError=="function"||typeof r.componentDidCatch=="function"&&(Xt===null||!Xt.has(r))){e=nr(n,e),e=D0(t,e,1),t=Zt(t,e,1),e=De(),t!==null&&(li(t,1,e),Ze(t,e));break}}t=t.return}}function k2(e,t,n){var r=e.pingCache;r!==null&&r.delete(t),t=De(),e.pingedLanes|=e.suspendedLanes&n,ke===e&&(Ne&n)===n&&(xe===4||xe===3&&(Ne&130023424)===Ne&&500>he()-$s?mn(e,0):As|=n),Ze(e,t)}function ld(e,t){t===0&&((e.mode&1)===0?t=1:(t=xi,xi<<=1,(xi&130023424)===0&&(xi=4194304)));var n=De();e=Ot(e,t),e!==null&&(li(e,t,n),Ze(e,n))}function S2(e){var t=e.memoizedState,n=0;t!==null&&(n=t.retryLane),ld(e,n)}function E2(e,t){var n=0;switch(e.tag){case 13:var r=e.stateNode,i=e.memoizedState;i!==null&&(n=i.retryLane);break;case 19:r=e.stateNode;break;default:throw Error(R(314))}r!==null&&r.delete(t),ld(e,n)}var ad;ad=function(e,t,n){if(e!==null)if(e.memoizedProps!==t.pendingProps||Ye.current)Ge=!0;else{if((e.lanes&n)===0&&(t.flags&128)===0)return Ge=!1,d2(e,t,n);Ge=(e.flags&131072)!==0}else Ge=!1,ae&&(t.flags&1048576)!==0&&c0(t,so,t.index);switch(t.lanes=0,t.tag){case 2:var r=t.type;Hi(e,t),e=t.pendingProps;var i=Jn(t,$e.current);Kn(t,n),i=Ns(null,t,r,e,i,n);var o=Ts();return t.flags|=1,typeof i=="object"&&i!==null&&typeof i.render=="function"&&i.$$typeof===void 0?(t.tag=1,t.memoizedState=null,t.updateQueue=null,Ke(r)?(o=!0,lo(t)):o=!1,t.memoizedState=i.state!==null&&i.state!==void 0?i.state:null,Es(t),i.updater=_o,t.stateNode=i,i._reactInternals=t,Sa(t,r,e,n),t=za(null,t,r,!0,o,n)):(t.tag=0,ae&&o&&vs(t),je(null,t,i,n),t=t.child),t;case 16:r=t.elementType;e:{switch(Hi(e,t),e=t.pendingProps,i=r._init,r=i(r._payload),t.type=r,i=t.tag=z2(r),e=pt(r,e),i){case 0:t=Pa(null,t,r,e,n);break e;case 1:t=e1(null,t,r,e,n);break e;case 11:t=Ju(null,t,r,e,n);break e;case 14:t=qu(null,t,r,pt(r.type,e),n);break e}throw Error(R(306,r,""))}return t;case 0:return r=t.type,i=t.pendingProps,i=t.elementType===r?i:pt(r,i),Pa(e,t,r,i,n);case 1:return r=t.type,i=t.pendingProps,i=t.elementType===r?i:pt(r,i),e1(e,t,r,i,n);case 3:e:{if(V0(t),e===null)throw Error(R(387));r=t.pendingProps,o=t.memoizedState,i=o.element,h0(e,t),fo(t,r,null,n);var l=t.memoizedState;if(r=l.element,o.isDehydrated)if(o={element:r,isDehydrated:!1,cache:l.cache,pendingSuspenseBoundaries:l.pendingSuspenseBoundaries,transitions:l.transitions},t.updateQueue.baseState=o,t.memoizedState=o,t.flags&256){i=nr(Error(R(423)),t),t=t1(e,t,r,n,i);break e}else if(r!==i){i=nr(Error(R(424)),t),t=t1(e,t,r,n,i);break e}else for(Je=Kt(t.stateNode.containerInfo.firstChild),et=t,ae=!0,mt=null,n=y0(t,null,r,n),t.child=n;n;)n.flags=n.flags&-3|4096,n=n.sibling;else{if(qn(),r===i){t=At(e,t,n);break e}je(e,t,r,n)}t=t.child}return t;case 5:return w0(t),e===null&&xa(t),r=t.type,i=t.pendingProps,o=e!==null?e.memoizedProps:null,l=i.children,ma(r,i)?l=null:o!==null&&ma(r,o)&&(t.flags|=32),U0(e,t),je(e,t,l,n),t.child;case 6:return e===null&&xa(t),null;case 13:return W0(e,t,n);case 4:return Ps(t,t.stateNode.containerInfo),r=t.pendingProps,e===null?t.child=er(t,null,r,n):je(e,t,r,n),t.child;case 11:return r=t.type,i=t.pendingProps,i=t.elementType===r?i:pt(r,i),Ju(e,t,r,i,n);case 7:return je(e,t,t.pendingProps,n),t.child;case 8:return je(e,t,t.pendingProps.children,n),t.child;case 12:return je(e,t,t.pendingProps.children,n),t.child;case 10:e:{if(r=t.type._context,i=t.pendingProps,o=t.memoizedProps,l=i.value,ie(uo,r._currentValue),r._currentValue=l,o!==null)if(wt(o.value,l)){if(o.children===i.children&&!Ye.current){t=At(e,t,n);break e}}else for(o=t.child,o!==null&&(o.return=t);o!==null;){var s=o.dependencies;if(s!==null){l=o.child;for(var u=s.firstContext;u!==null;){if(u.context===r){if(o.tag===1){u=bt(-1,n&-n),u.tag=2;var c=o.updateQueue;if(c!==null){c=c.shared;var p=c.pending;p===null?u.next=u:(u.next=p.next,p.next=u),c.pending=u}}o.lanes|=n,u=o.alternate,u!==null&&(u.lanes|=n),Ca(o.return,n,t),s.lanes|=n;break}u=u.next}}else if(o.tag===10)l=o.type===t.type?null:o.child;else if(o.tag===18){if(l=o.return,l===null)throw Error(R(341));l.lanes|=n,s=l.alternate,s!==null&&(s.lanes|=n),Ca(l,n,t),l=o.sibling}else l=o.child;if(l!==null)l.return=o;else for(l=o;l!==null;){if(l===t){l=null;break}if(o=l.sibling,o!==null){o.return=l.return,l=o;break}l=l.return}o=l}je(e,t,i.children,n),t=t.child}return t;case 9:return i=t.type,r=t.pendingProps.children,Kn(t,n),i=ut(i),r=r(i),t.flags|=1,je(e,t,r,n),t.child;case 14:return r=t.type,i=pt(r,t.pendingProps),i=pt(r.type,i),qu(e,t,r,i,n);case 15:return B0(e,t,t.type,t.pendingProps,n);case 17:return r=t.type,i=t.pendingProps,i=t.elementType===r?i:pt(r,i),Hi(e,t),t.tag=1,Ke(r)?(e=!0,lo(t)):e=!1,Kn(t,n),g0(t,r,i),Sa(t,r,i,n),za(null,t,r,!0,e,n);case 19:return G0(e,t,n);case 22:return H0(e,t,n)}throw Error(R(156,t.tag))};function sd(e,t){return Oc(e,t)}function P2(e,t,n,r){this.tag=e,this.key=n,this.sibling=this.child=this.return=this.stateNode=this.type=this.elementType=null,this.index=0,this.ref=null,this.pendingProps=t,this.dependencies=this.memoizedState=this.updateQueue=this.memoizedProps=null,this.mode=r,this.subtreeFlags=this.flags=0,this.deletions=null,this.childLanes=this.lanes=0,this.alternate=null}function at(e,t,n,r){return new P2(e,t,n,r)}function Ds(e){return e=e.prototype,!(!e||!e.isReactComponent)}function z2(e){if(typeof e=="function")return Ds(e)?1:0;if(e!=null){if(e=e.$$typeof,e===os)return 11;if(e===ls)return 14}return 2}function qt(e,t){var n=e.alternate;return n===null?(n=at(e.tag,t,e.key,e.mode),n.elementType=e.elementType,n.type=e.type,n.stateNode=e.stateNode,n.alternate=e,e.alternate=n):(n.pendingProps=t,n.type=e.type,n.flags=0,n.subtreeFlags=0,n.deletions=null),n.flags=e.flags&14680064,n.childLanes=e.childLanes,n.lanes=e.lanes,n.child=e.child,n.memoizedProps=e.memoizedProps,n.memoizedState=e.memoizedState,n.updateQueue=e.updateQueue,t=e.dependencies,n.dependencies=t===null?null:{lanes:t.lanes,firstContext:t.firstContext},n.sibling=e.sibling,n.index=e.index,n.ref=e.ref,n}function Wi(e,t,n,r,i,o){var l=2;if(r=e,typeof e=="function")Ds(e)&&(l=1);else if(typeof e=="string")l=5;else e:switch(e){case Mn:return gn(n.children,i,o,t);case is:l=8,i|=8;break;case Ql:return e=at(12,n,t,i|2),e.elementType=Ql,e.lanes=o,e;case Yl:return e=at(13,n,t,i),e.elementType=Yl,e.lanes=o,e;case Kl:return e=at(19,n,t,i),e.elementType=Kl,e.lanes=o,e;case vc:return $o(n,i,o,t);default:if(typeof e=="object"&&e!==null)switch(e.$$typeof){case mc:l=10;break e;case gc:l=9;break e;case os:l=11;break e;case ls:l=14;break e;case jt:l=16,r=null;break e}throw Error(R(130,e==null?e:typeof e,""))}return t=at(l,n,t,i),t.elementType=e,t.type=r,t.lanes=o,t}function gn(e,t,n,r){return e=at(7,e,r,t),e.lanes=n,e}function $o(e,t,n,r){return e=at(22,e,r,t),e.elementType=vc,e.lanes=n,e.stateNode={isHidden:!1},e}function Ol(e,t,n){return e=at(6,e,null,t),e.lanes=n,e}function Al(e,t,n){return t=at(4,e.children!==null?e.children:[],e.key,t),t.lanes=n,t.stateNode={containerInfo:e.containerInfo,pendingChildren:null,implementation:e.implementation},t}function R2(e,t,n,r,i){this.tag=t,this.containerInfo=e,this.finishedWork=this.pingCache=this.current=this.pendingChildren=null,this.timeoutHandle=-1,this.callbackNode=this.pendingContext=this.context=null,this.callbackPriority=0,this.eventTimes=ml(0),this.expirationTimes=ml(-1),this.entangledLanes=this.finishedLanes=this.mutableReadLanes=this.expiredLanes=this.pingedLanes=this.suspendedLanes=this.pendingLanes=0,this.entanglements=ml(0),this.identifierPrefix=r,this.onRecoverableError=i,this.mutableSourceEagerHydrationData=null}function Bs(e,t,n,r,i,o,l,s,u){return e=new R2(e,t,n,s,u),t===1?(t=1,o===!0&&(t|=8)):t=0,o=at(3,null,null,t),e.current=o,o.stateNode=e,o.memoizedState={element:r,isDehydrated:n,cache:null,transitions:null,pendingSuspenseBoundaries:null},Es(o),e}function L2(e,t,n){var r=3<arguments.length&&arguments[3]!==void 0?arguments[3]:null;return{$$typeof:_n,key:r==null?null:""+r,children:e,containerInfo:t,implementation:n}}function ud(e){if(!e)return on;e=e._reactInternals;e:{if(Pn(e)!==e||e.tag!==1)throw Error(R(170));var t=e;do{switch(t.tag){case 3:t=t.stateNode.context;break e;case 1:if(Ke(t.type)){t=t.stateNode.__reactInternalMemoizedMergedChildContext;break e}}t=t.return}while(t!==null);throw Error(R(171))}if(e.tag===1){var n=e.type;if(Ke(n))return s0(e,n,t)}return t}function cd(e,t,n,r,i,o,l,s,u){return e=Bs(n,r,!0,e,i,o,l,s,u),e.context=ud(null),n=e.current,r=De(),i=Jt(n),o=bt(r,i),o.callback=t!=null?t:null,Zt(n,o,i),e.current.lanes=i,li(e,i,r),Ze(e,r),e}function Io(e,t,n,r){var i=t.current,o=De(),l=Jt(i);return n=ud(n),t.context===null?t.context=n:t.pendingContext=n,t=bt(o,l),t.payload={element:e},r=r===void 0?null:r,r!==null&&(t.callback=r),e=Zt(i,t,l),e!==null&&(yt(e,i,l,o),ji(e,i,l)),l}function xo(e){if(e=e.current,!e.child)return null;switch(e.child.tag){case 5:return e.child.stateNode;default:return e.child.stateNode}}function d1(e,t){if(e=e.memoizedState,e!==null&&e.dehydrated!==null){var n=e.retryLane;e.retryLane=n!==0&&n<t?n:t}}function Hs(e,t){d1(e,t),(e=e.alternate)&&d1(e,t)}function N2(){return null}var dd=typeof reportError=="function"?reportError:function(e){console.error(e)};function Us(e){this._internalRoot=e}Fo.prototype.render=Us.prototype.render=function(e){var t=this._internalRoot;if(t===null)throw Error(R(409));Io(e,t,null,null)};Fo.prototype.unmount=Us.prototype.unmount=function(){var e=this._internalRoot;if(e!==null){this._internalRoot=null;var t=e.containerInfo;Cn(function(){Io(null,e,null,null)}),t[Mt]=null}};function Fo(e){this._internalRoot=e}Fo.prototype.unstable_scheduleHydration=function(e){if(e){var t=Bc();e={blockedOn:null,target:e,priority:t};for(var n=0;n<Bt.length&&t!==0&&t<Bt[n].priority;n++);Bt.splice(n,0,e),n===0&&Uc(e)}};function Vs(e){return!(!e||e.nodeType!==1&&e.nodeType!==9&&e.nodeType!==11)}function jo(e){return!(!e||e.nodeType!==1&&e.nodeType!==9&&e.nodeType!==11&&(e.nodeType!==8||e.nodeValue!==" react-mount-point-unstable "))}function f1(){}function T2(e,t,n,r,i){if(i){if(typeof r=="function"){var o=r;r=function(){var c=xo(l);o.call(c)}}var l=cd(t,r,e,0,null,!1,!1,"",f1);return e._reactRootContainer=l,e[Mt]=l.current,Qr(e.nodeType===8?e.parentNode:e),Cn(),l}for(;i=e.lastChild;)e.removeChild(i);if(typeof r=="function"){var s=r;r=function(){var c=xo(u);s.call(c)}}var u=Bs(e,0,!1,null,null,!1,!1,"",f1);return e._reactRootContainer=u,e[Mt]=u.current,Qr(e.nodeType===8?e.parentNode:e),Cn(function(){Io(t,u,n,r)}),u}function Do(e,t,n,r,i){var o=n._reactRootContainer;if(o){var l=o;if(typeof i=="function"){var s=i;i=function(){var u=xo(l);s.call(u)}}Io(t,l,e,i)}else l=T2(n,t,e,i,r);return xo(l)}jc=function(e){switch(e.tag){case 3:var t=e.stateNode;if(t.current.memoizedState.isDehydrated){var n=zr(t.pendingLanes);n!==0&&(us(t,n|1),Ze(t,he()),(K&6)===0&&(rr=he()+500,sn()))}break;case 13:Cn(function(){var r=Ot(e,1);if(r!==null){var i=De();yt(r,e,1,i)}}),Hs(e,1)}};cs=function(e){if(e.tag===13){var t=Ot(e,134217728);if(t!==null){var n=De();yt(t,e,134217728,n)}Hs(e,134217728)}};Dc=function(e){if(e.tag===13){var t=Jt(e),n=Ot(e,t);if(n!==null){var r=De();yt(n,e,t,r)}Hs(e,t)}};Bc=function(){return ee};Hc=function(e,t){var n=ee;try{return ee=e,t()}finally{ee=n}};oa=function(e,t,n){switch(t){case"input":if(Jl(e,n),t=n.name,n.type==="radio"&&t!=null){for(n=e;n.parentNode;)n=n.parentNode;for(n=n.querySelectorAll("input[name="+JSON.stringify(""+t)+'][type="radio"]'),t=0;t<n.length;t++){var r=n[t];if(r!==e&&r.form===e.form){var i=To(r);if(!i)throw Error(R(90));wc(r),Jl(r,i)}}}break;case"textarea":Cc(e,n);break;case"select":t=n.value,t!=null&&Wn(e,!!n.multiple,t,!1)}};Lc=Is;Nc=Cn;var b2={usingClientEntryPoint:!1,Events:[si,In,To,zc,Rc,Is]},Sr={findFiberByHostInstance:fn,bundleType:0,version:"18.2.0",rendererPackageName:"react-dom"},_2={bundleType:Sr.bundleType,version:Sr.version,rendererPackageName:Sr.rendererPackageName,rendererConfig:Sr.rendererConfig,overrideHookState:null,overrideHookStateDeletePath:null,overrideHookStateRenamePath:null,overrideProps:null,overridePropsDeletePath:null,overridePropsRenamePath:null,setErrorHandler:null,setSuspenseHandler:null,scheduleUpdate:null,currentDispatcherRef:$t.ReactCurrentDispatcher,findHostInstanceByFiber:function(e){return e=_c(e),e===null?null:e.stateNode},findFiberByHostInstance:Sr.findFiberByHostInstance||N2,findHostInstancesForRefresh:null,scheduleRefresh:null,scheduleRoot:null,setRefreshHandler:null,getCurrentFiber:null,reconcilerVersion:"18.2.0-next-9e3b772b8-20220608"};if(typeof __REACT_DEVTOOLS_GLOBAL_HOOK__!="undefined"){var bi=__REACT_DEVTOOLS_GLOBAL_HOOK__;if(!bi.isDisabled&&bi.supportsFiber)try{zo=bi.inject(_2),St=bi}catch{}}nt.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED=b2;nt.createPortal=function(e,t){var n=2<arguments.length&&arguments[2]!==void 0?arguments[2]:null;if(!Vs(t))throw Error(R(200));return L2(e,t,null,n)};nt.createRoot=function(e,t){if(!Vs(e))throw Error(R(299));var n=!1,r="",i=dd;return t!=null&&(t.unstable_strictMode===!0&&(n=!0),t.identifierPrefix!==void 0&&(r=t.identifierPrefix),t.onRecoverableError!==void 0&&(i=t.onRecoverableError)),t=Bs(e,1,!1,null,null,n,!1,r,i),e[Mt]=t.current,Qr(e.nodeType===8?e.parentNode:e),new Us(t)};nt.findDOMNode=function(e){if(e==null)return null;if(e.nodeType===1)return e;var t=e._reactInternals;if(t===void 0)throw typeof e.render=="function"?Error(R(188)):(e=Object.keys(e).join(","),Error(R(268,e)));return e=_c(t),e=e===null?null:e.stateNode,e};nt.flushSync=function(e){return Cn(e)};nt.hydrate=function(e,t,n){if(!jo(t))throw Error(R(200));return Do(null,e,t,!0,n)};nt.hydrateRoot=function(e,t,n){if(!Vs(e))throw Error(R(405));var r=n!=null&&n.hydratedSources||null,i=!1,o="",l=dd;if(n!=null&&(n.unstable_strictMode===!0&&(i=!0),n.identifierPrefix!==void 0&&(o=n.identifierPrefix),n.onRecoverableError!==void 0&&(l=n.onRecoverableError)),t=cd(t,null,e,1,n!=null?n:null,i,!1,o,l),e[Mt]=t.current,Qr(e),r)for(e=0;e<r.length;e++)n=r[e],i=n._getVersion,i=i(n._source),t.mutableSourceEagerHydrationData==null?t.mutableSourceEagerHydrationData=[n,i]:t.mutableSourceEagerHydrationData.push(n,i);return new Fo(t)};nt.render=function(e,t,n){if(!jo(t))throw Error(R(200));return Do(null,e,t,!1,n)};nt.unmountComponentAtNode=function(e){if(!jo(e))throw Error(R(40));return e._reactRootContainer?(Cn(function(){Do(null,null,e,!1,function(){e._reactRootContainer=null,e[Mt]=null})}),!0):!1};nt.unstable_batchedUpdates=Is;nt.unstable_renderSubtreeIntoContainer=function(e,t,n,r){if(!jo(n))throw Error(R(200));if(e==null||e._reactInternals===void 0)throw Error(R(38));return Do(e,t,n,!1,r)};nt.version="18.2.0-next-9e3b772b8-20220608";function fd(){if(!(typeof __REACT_DEVTOOLS_GLOBAL_HOOK__=="undefined"||typeof __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE!="function"))try{__REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE(fd)}catch(e){console.error(e)}}fd(),es.exports=nt;var M2=es.exports,p1=es.exports;Wl.createRoot=p1.createRoot,Wl.hydrateRoot=p1.hydrateRoot;var Bo={exports:{}},te={};/** @license React v16.13.1
 * react-is.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */var Se=typeof Symbol=="function"&&Symbol.for,Ws=Se?Symbol.for("react.element"):60103,Gs=Se?Symbol.for("react.portal"):60106,Ho=Se?Symbol.for("react.fragment"):60107,Uo=Se?Symbol.for("react.strict_mode"):60108,Vo=Se?Symbol.for("react.profiler"):60114,Wo=Se?Symbol.for("react.provider"):60109,Go=Se?Symbol.for("react.context"):60110,Qs=Se?Symbol.for("react.async_mode"):60111,Qo=Se?Symbol.for("react.concurrent_mode"):60111,Yo=Se?Symbol.for("react.forward_ref"):60112,Ko=Se?Symbol.for("react.suspense"):60113,O2=Se?Symbol.for("react.suspense_list"):60120,Zo=Se?Symbol.for("react.memo"):60115,Xo=Se?Symbol.for("react.lazy"):60116,A2=Se?Symbol.for("react.block"):60121,$2=Se?Symbol.for("react.fundamental"):60117,I2=Se?Symbol.for("react.responder"):60118,F2=Se?Symbol.for("react.scope"):60119;function it(e){if(typeof e=="object"&&e!==null){var t=e.$$typeof;switch(t){case Ws:switch(e=e.type,e){case Qs:case Qo:case Ho:case Vo:case Uo:case Ko:return e;default:switch(e=e&&e.$$typeof,e){case Go:case Yo:case Xo:case Zo:case Wo:return e;default:return t}}case Gs:return t}}}function pd(e){return it(e)===Qo}te.AsyncMode=Qs;te.ConcurrentMode=Qo;te.ContextConsumer=Go;te.ContextProvider=Wo;te.Element=Ws;te.ForwardRef=Yo;te.Fragment=Ho;te.Lazy=Xo;te.Memo=Zo;te.Portal=Gs;te.Profiler=Vo;te.StrictMode=Uo;te.Suspense=Ko;te.isAsyncMode=function(e){return pd(e)||it(e)===Qs};te.isConcurrentMode=pd;te.isContextConsumer=function(e){return it(e)===Go};te.isContextProvider=function(e){return it(e)===Wo};te.isElement=function(e){return typeof e=="object"&&e!==null&&e.$$typeof===Ws};te.isForwardRef=function(e){return it(e)===Yo};te.isFragment=function(e){return it(e)===Ho};te.isLazy=function(e){return it(e)===Xo};te.isMemo=function(e){return it(e)===Zo};te.isPortal=function(e){return it(e)===Gs};te.isProfiler=function(e){return it(e)===Vo};te.isStrictMode=function(e){return it(e)===Uo};te.isSuspense=function(e){return it(e)===Ko};te.isValidElementType=function(e){return typeof e=="string"||typeof e=="function"||e===Ho||e===Qo||e===Vo||e===Uo||e===Ko||e===O2||typeof e=="object"&&e!==null&&(e.$$typeof===Xo||e.$$typeof===Zo||e.$$typeof===Wo||e.$$typeof===Go||e.$$typeof===Yo||e.$$typeof===$2||e.$$typeof===I2||e.$$typeof===F2||e.$$typeof===A2)};te.typeOf=it;Bo.exports=te;function j2(e){function t(T,O,A,D,S){for(var G=0,N=0,de=0,X=0,q,U,Ee=0,Ue=0,Z,_e=Z=q=0,J=0,Pe=0,hr=0,ze=0,hi=A.length,mr=hi-1,dt,B="",pe="",sl="",ul="",It;J<hi;){if(U=A.charCodeAt(J),J===mr&&N+X+de+G!==0&&(N!==0&&(U=N===47?10:47),X=de=G=0,hi++,mr++),N+X+de+G===0){if(J===mr&&(0<Pe&&(B=B.replace(m,"")),0<B.trim().length)){switch(U){case 32:case 9:case 59:case 13:case 10:break;default:B+=A.charAt(J)}U=59}switch(U){case 123:for(B=B.trim(),q=B.charCodeAt(0),Z=1,ze=++J;J<hi;){switch(U=A.charCodeAt(J)){case 123:Z++;break;case 125:Z--;break;case 47:switch(U=A.charCodeAt(J+1)){case 42:case 47:e:{for(_e=J+1;_e<mr;++_e)switch(A.charCodeAt(_e)){case 47:if(U===42&&A.charCodeAt(_e-1)===42&&J+2!==_e){J=_e+1;break e}break;case 10:if(U===47){J=_e+1;break e}}J=_e}}break;case 91:U++;case 40:U++;case 34:case 39:for(;J++<mr&&A.charCodeAt(J)!==U;);}if(Z===0)break;J++}switch(Z=A.substring(ze,J),q===0&&(q=(B=B.replace(g,"").trim()).charCodeAt(0)),q){case 64:switch(0<Pe&&(B=B.replace(m,"")),U=B.charCodeAt(1),U){case 100:case 109:case 115:case 45:Pe=O;break;default:Pe=Pt}if(Z=t(O,Pe,Z,U,S+1),ze=Z.length,0<L&&(Pe=n(Pt,B,hr),It=s(3,Z,Pe,O,ne,Q,ze,U,S,D),B=Pe.join(""),It!==void 0&&(ze=(Z=It.trim()).length)===0&&(U=0,Z="")),0<ze)switch(U){case 115:B=B.replace(_,l);case 100:case 109:case 45:Z=B+"{"+Z+"}";break;case 107:B=B.replace(d,"$1 $2"),Z=B+"{"+Z+"}",Z=be===1||be===2&&o("@"+Z,3)?"@-webkit-"+Z+"@"+Z:"@"+Z;break;default:Z=B+Z,D===112&&(Z=(pe+=Z,""))}else Z="";break;default:Z=t(O,n(O,B,hr),Z,D,S+1)}sl+=Z,Z=hr=Pe=_e=q=0,B="",U=A.charCodeAt(++J);break;case 125:case 59:if(B=(0<Pe?B.replace(m,""):B).trim(),1<(ze=B.length))switch(_e===0&&(q=B.charCodeAt(0),q===45||96<q&&123>q)&&(ze=(B=B.replace(" ",":")).length),0<L&&(It=s(1,B,O,T,ne,Q,pe.length,D,S,D))!==void 0&&(ze=(B=It.trim()).length)===0&&(B="\0\0"),q=B.charCodeAt(0),U=B.charCodeAt(1),q){case 0:break;case 64:if(U===105||U===99){ul+=B+A.charAt(J);break}default:B.charCodeAt(ze-1)!==58&&(pe+=i(B,q,U,B.charCodeAt(2)))}hr=Pe=_e=q=0,B="",U=A.charCodeAt(++J)}}switch(U){case 13:case 10:N===47?N=0:1+q===0&&D!==107&&0<B.length&&(Pe=1,B+="\0"),0<L*j&&s(0,B,O,T,ne,Q,pe.length,D,S,D),Q=1,ne++;break;case 59:case 125:if(N+X+de+G===0){Q++;break}default:switch(Q++,dt=A.charAt(J),U){case 9:case 32:if(X+G+N===0)switch(Ee){case 44:case 58:case 9:case 32:dt="";break;default:U!==32&&(dt=" ")}break;case 0:dt="\\0";break;case 12:dt="\\f";break;case 11:dt="\\v";break;case 38:X+N+G===0&&(Pe=hr=1,dt="\f"+dt);break;case 108:if(X+N+G+me===0&&0<_e)switch(J-_e){case 2:Ee===112&&A.charCodeAt(J-3)===58&&(me=Ee);case 8:Ue===111&&(me=Ue)}break;case 58:X+N+G===0&&(_e=J);break;case 44:N+de+X+G===0&&(Pe=1,dt+="\r");break;case 34:case 39:N===0&&(X=X===U?0:X===0?U:X);break;case 91:X+N+de===0&&G++;break;case 93:X+N+de===0&&G--;break;case 41:X+N+G===0&&de--;break;case 40:if(X+N+G===0){if(q===0)switch(2*Ee+3*Ue){case 533:break;default:q=1}de++}break;case 64:N+de+X+G+_e+Z===0&&(Z=1);break;case 42:case 47:if(!(0<X+G+de))switch(N){case 0:switch(2*U+3*A.charCodeAt(J+1)){case 235:N=47;break;case 220:ze=J,N=42}break;case 42:U===47&&Ee===42&&ze+2!==J&&(A.charCodeAt(ze+2)===33&&(pe+=A.substring(ze,J+1)),dt="",N=0)}}N===0&&(B+=dt)}Ue=Ee,Ee=U,J++}if(ze=pe.length,0<ze){if(Pe=O,0<L&&(It=s(2,pe,Pe,T,ne,Q,ze,D,S,D),It!==void 0&&(pe=It).length===0))return ul+pe+sl;if(pe=Pe.join(",")+"{"+pe+"}",be*me!==0){switch(be!==2||o(pe,2)||(me=0),me){case 111:pe=pe.replace(k,":-moz-$1")+pe;break;case 112:pe=pe.replace(h,"::-webkit-input-$1")+pe.replace(h,"::-moz-$1")+pe.replace(h,":-ms-input-$1")+pe}me=0}}return ul+pe+sl}function n(T,O,A){var D=O.trim().split(P);O=D;var S=D.length,G=T.length;switch(G){case 0:case 1:var N=0;for(T=G===0?"":T[0]+" ";N<S;++N)O[N]=r(T,O[N],A).trim();break;default:var de=N=0;for(O=[];N<S;++N)for(var X=0;X<G;++X)O[de++]=r(T[X]+" ",D[N],A).trim()}return O}function r(T,O,A){var D=O.charCodeAt(0);switch(33>D&&(D=(O=O.trim()).charCodeAt(0)),D){case 38:return O.replace(f,"$1"+T.trim());case 58:return T.trim()+O.replace(f,"$1"+T.trim());default:if(0<1*A&&0<O.indexOf("\f"))return O.replace(f,(T.charCodeAt(0)===58?"":"$1")+T.trim())}return T+O}function i(T,O,A,D){var S=T+";",G=2*O+3*A+4*D;if(G===944){T=S.indexOf(":",9)+1;var N=S.substring(T,S.length-1).trim();return N=S.substring(0,T).trim()+N+";",be===1||be===2&&o(N,1)?"-webkit-"+N+N:N}if(be===0||be===2&&!o(S,1))return S;switch(G){case 1015:return S.charCodeAt(10)===97?"-webkit-"+S+S:S;case 951:return S.charCodeAt(3)===116?"-webkit-"+S+S:S;case 963:return S.charCodeAt(5)===110?"-webkit-"+S+S:S;case 1009:if(S.charCodeAt(4)!==100)break;case 969:case 942:return"-webkit-"+S+S;case 978:return"-webkit-"+S+"-moz-"+S+S;case 1019:case 983:return"-webkit-"+S+"-moz-"+S+"-ms-"+S+S;case 883:if(S.charCodeAt(8)===45)return"-webkit-"+S+S;if(0<S.indexOf("image-set(",11))return S.replace(H,"$1-webkit-$2")+S;break;case 932:if(S.charCodeAt(4)===45)switch(S.charCodeAt(5)){case 103:return"-webkit-box-"+S.replace("-grow","")+"-webkit-"+S+"-ms-"+S.replace("grow","positive")+S;case 115:return"-webkit-"+S+"-ms-"+S.replace("shrink","negative")+S;case 98:return"-webkit-"+S+"-ms-"+S.replace("basis","preferred-size")+S}return"-webkit-"+S+"-ms-"+S+S;case 964:return"-webkit-"+S+"-ms-flex-"+S+S;case 1023:if(S.charCodeAt(8)!==99)break;return N=S.substring(S.indexOf(":",15)).replace("flex-","").replace("space-between","justify"),"-webkit-box-pack"+N+"-webkit-"+S+"-ms-flex-pack"+N+S;case 1005:return y.test(S)?S.replace(C,":-webkit-")+S.replace(C,":-moz-")+S:S;case 1e3:switch(N=S.substring(13).trim(),O=N.indexOf("-")+1,N.charCodeAt(0)+N.charCodeAt(O)){case 226:N=S.replace(z,"tb");break;case 232:N=S.replace(z,"tb-rl");break;case 220:N=S.replace(z,"lr");break;default:return S}return"-webkit-"+S+"-ms-"+N+S;case 1017:if(S.indexOf("sticky",9)===-1)break;case 975:switch(O=(S=T).length-10,N=(S.charCodeAt(O)===33?S.substring(0,O):S).substring(T.indexOf(":",7)+1).trim(),G=N.charCodeAt(0)+(N.charCodeAt(7)|0)){case 203:if(111>N.charCodeAt(8))break;case 115:S=S.replace(N,"-webkit-"+N)+";"+S;break;case 207:case 102:S=S.replace(N,"-webkit-"+(102<G?"inline-":"")+"box")+";"+S.replace(N,"-webkit-"+N)+";"+S.replace(N,"-ms-"+N+"box")+";"+S}return S+";";case 938:if(S.charCodeAt(5)===45)switch(S.charCodeAt(6)){case 105:return N=S.replace("-items",""),"-webkit-"+S+"-webkit-box-"+N+"-ms-flex-"+N+S;case 115:return"-webkit-"+S+"-ms-flex-item-"+S.replace(b,"")+S;default:return"-webkit-"+S+"-ms-flex-line-pack"+S.replace("align-content","").replace(b,"")+S}break;case 973:case 989:if(S.charCodeAt(3)!==45||S.charCodeAt(4)===122)break;case 931:case 953:if(I.test(T)===!0)return(N=T.substring(T.indexOf(":")+1)).charCodeAt(0)===115?i(T.replace("stretch","fill-available"),O,A,D).replace(":fill-available",":stretch"):S.replace(N,"-webkit-"+N)+S.replace(N,"-moz-"+N.replace("fill-",""))+S;break;case 962:if(S="-webkit-"+S+(S.charCodeAt(5)===102?"-ms-"+S:"")+S,A+D===211&&S.charCodeAt(13)===105&&0<S.indexOf("transform",10))return S.substring(0,S.indexOf(";",27)+1).replace(w,"$1-webkit-$2")+S}return S}function o(T,O){var A=T.indexOf(O===1?":":"{"),D=T.substring(0,O!==3?A:10);return A=T.substring(A+1,T.length-1),F(O!==2?D:D.replace(V,"$1"),A,O)}function l(T,O){var A=i(O,O.charCodeAt(0),O.charCodeAt(1),O.charCodeAt(2));return A!==O+";"?A.replace(M," or ($1)").substring(4):"("+O+")"}function s(T,O,A,D,S,G,N,de,X,q){for(var U=0,Ee=O,Ue;U<L;++U)switch(Ue=Fe[U].call(p,T,Ee,A,D,S,G,N,de,X,q)){case void 0:case!1:case!0:case null:break;default:Ee=Ue}if(Ee!==O)return Ee}function u(T){switch(T){case void 0:case null:L=Fe.length=0;break;default:if(typeof T=="function")Fe[L++]=T;else if(typeof T=="object")for(var O=0,A=T.length;O<A;++O)u(T[O]);else j=!!T|0}return u}function c(T){return T=T.prefix,T!==void 0&&(F=null,T?typeof T!="function"?be=1:(be=2,F=T):be=0),c}function p(T,O){var A=T;if(33>A.charCodeAt(0)&&(A=A.trim()),re=A,A=[re],0<L){var D=s(-1,O,A,A,ne,Q,0,0,0,0);D!==void 0&&typeof D=="string"&&(O=D)}var S=t(Pt,A,O,0,0);return 0<L&&(D=s(-2,S,A,A,ne,Q,S.length,0,0,0),D!==void 0&&(S=D)),re="",me=0,Q=ne=1,S}var g=/^\0+/g,m=/[\0\r\f]/g,C=/: */g,y=/zoo|gra/,w=/([,: ])(transform)/g,P=/,\r+?/g,f=/([\t\r\n ])*\f?&/g,d=/@(k\w+)\s*(\S*)\s*/,h=/::(place)/g,k=/:(read-only)/g,z=/[svh]\w+-[tblr]{2}/,_=/\(\s*(.*)\s*\)/g,M=/([\s\S]*?);/g,b=/-self|flex-/g,V=/[^]*?(:[rp][el]a[\w-]+)[^]*/,I=/stretch|:\s*\w+\-(?:conte|avail)/,H=/([^-])(image-set\()/,Q=1,ne=1,me=0,be=1,Pt=[],Fe=[],L=0,F=null,j=0,re="";return p.use=u,p.set=c,e!==void 0&&c(e),p}var D2={animationIterationCount:1,borderImageOutset:1,borderImageSlice:1,borderImageWidth:1,boxFlex:1,boxFlexGroup:1,boxOrdinalGroup:1,columnCount:1,columns:1,flex:1,flexGrow:1,flexPositive:1,flexShrink:1,flexNegative:1,flexOrder:1,gridRow:1,gridRowEnd:1,gridRowSpan:1,gridRowStart:1,gridColumn:1,gridColumnEnd:1,gridColumnSpan:1,gridColumnStart:1,msGridRow:1,msGridRowSpan:1,msGridColumn:1,msGridColumnSpan:1,fontWeight:1,lineHeight:1,opacity:1,order:1,orphans:1,tabSize:1,widows:1,zIndex:1,zoom:1,WebkitLineClamp:1,fillOpacity:1,floodOpacity:1,stopOpacity:1,strokeDasharray:1,strokeDashoffset:1,strokeMiterlimit:1,strokeOpacity:1,strokeWidth:1};function B2(e){var t=Object.create(null);return function(n){return t[n]===void 0&&(t[n]=e(n)),t[n]}}var H2=/^((children|dangerouslySetInnerHTML|key|ref|autoFocus|defaultValue|defaultChecked|innerHTML|suppressContentEditableWarning|suppressHydrationWarning|valueLink|abbr|accept|acceptCharset|accessKey|action|allow|allowUserMedia|allowPaymentRequest|allowFullScreen|allowTransparency|alt|async|autoComplete|autoPlay|capture|cellPadding|cellSpacing|challenge|charSet|checked|cite|classID|className|cols|colSpan|content|contentEditable|contextMenu|controls|controlsList|coords|crossOrigin|data|dateTime|decoding|default|defer|dir|disabled|disablePictureInPicture|download|draggable|encType|enterKeyHint|form|formAction|formEncType|formMethod|formNoValidate|formTarget|frameBorder|headers|height|hidden|high|href|hrefLang|htmlFor|httpEquiv|id|inputMode|integrity|is|keyParams|keyType|kind|label|lang|list|loading|loop|low|marginHeight|marginWidth|max|maxLength|media|mediaGroup|method|min|minLength|multiple|muted|name|nonce|noValidate|open|optimum|pattern|placeholder|playsInline|poster|preload|profile|radioGroup|readOnly|referrerPolicy|rel|required|reversed|role|rows|rowSpan|sandbox|scope|scoped|scrolling|seamless|selected|shape|size|sizes|slot|span|spellCheck|src|srcDoc|srcLang|srcSet|start|step|style|summary|tabIndex|target|title|translate|type|useMap|value|width|wmode|wrap|about|datatype|inlist|prefix|property|resource|typeof|vocab|autoCapitalize|autoCorrect|autoSave|color|incremental|fallback|inert|itemProp|itemScope|itemType|itemID|itemRef|on|option|results|security|unselectable|accentHeight|accumulate|additive|alignmentBaseline|allowReorder|alphabetic|amplitude|arabicForm|ascent|attributeName|attributeType|autoReverse|azimuth|baseFrequency|baselineShift|baseProfile|bbox|begin|bias|by|calcMode|capHeight|clip|clipPathUnits|clipPath|clipRule|colorInterpolation|colorInterpolationFilters|colorProfile|colorRendering|contentScriptType|contentStyleType|cursor|cx|cy|d|decelerate|descent|diffuseConstant|direction|display|divisor|dominantBaseline|dur|dx|dy|edgeMode|elevation|enableBackground|end|exponent|externalResourcesRequired|fill|fillOpacity|fillRule|filter|filterRes|filterUnits|floodColor|floodOpacity|focusable|fontFamily|fontSize|fontSizeAdjust|fontStretch|fontStyle|fontVariant|fontWeight|format|from|fr|fx|fy|g1|g2|glyphName|glyphOrientationHorizontal|glyphOrientationVertical|glyphRef|gradientTransform|gradientUnits|hanging|horizAdvX|horizOriginX|ideographic|imageRendering|in|in2|intercept|k|k1|k2|k3|k4|kernelMatrix|kernelUnitLength|kerning|keyPoints|keySplines|keyTimes|lengthAdjust|letterSpacing|lightingColor|limitingConeAngle|local|markerEnd|markerMid|markerStart|markerHeight|markerUnits|markerWidth|mask|maskContentUnits|maskUnits|mathematical|mode|numOctaves|offset|opacity|operator|order|orient|orientation|origin|overflow|overlinePosition|overlineThickness|panose1|paintOrder|pathLength|patternContentUnits|patternTransform|patternUnits|pointerEvents|points|pointsAtX|pointsAtY|pointsAtZ|preserveAlpha|preserveAspectRatio|primitiveUnits|r|radius|refX|refY|renderingIntent|repeatCount|repeatDur|requiredExtensions|requiredFeatures|restart|result|rotate|rx|ry|scale|seed|shapeRendering|slope|spacing|specularConstant|specularExponent|speed|spreadMethod|startOffset|stdDeviation|stemh|stemv|stitchTiles|stopColor|stopOpacity|strikethroughPosition|strikethroughThickness|string|stroke|strokeDasharray|strokeDashoffset|strokeLinecap|strokeLinejoin|strokeMiterlimit|strokeOpacity|strokeWidth|surfaceScale|systemLanguage|tableValues|targetX|targetY|textAnchor|textDecoration|textRendering|textLength|to|transform|u1|u2|underlinePosition|underlineThickness|unicode|unicodeBidi|unicodeRange|unitsPerEm|vAlphabetic|vHanging|vIdeographic|vMathematical|values|vectorEffect|version|vertAdvY|vertOriginX|vertOriginY|viewBox|viewTarget|visibility|widths|wordSpacing|writingMode|x|xHeight|x1|x2|xChannelSelector|xlinkActuate|xlinkArcrole|xlinkHref|xlinkRole|xlinkShow|xlinkTitle|xlinkType|xmlBase|xmlns|xmlnsXlink|xmlLang|xmlSpace|y|y1|y2|yChannelSelector|z|zoomAndPan|for|class|autofocus)|(([Dd][Aa][Tt][Aa]|[Aa][Rr][Ii][Aa]|x)-.*))$/,h1=B2(function(e){return H2.test(e)||e.charCodeAt(0)===111&&e.charCodeAt(1)===110&&e.charCodeAt(2)<91}),Ys=Bo.exports,U2={childContextTypes:!0,contextType:!0,contextTypes:!0,defaultProps:!0,displayName:!0,getDefaultProps:!0,getDerivedStateFromError:!0,getDerivedStateFromProps:!0,mixins:!0,propTypes:!0,type:!0},V2={name:!0,length:!0,prototype:!0,caller:!0,callee:!0,arguments:!0,arity:!0},W2={$$typeof:!0,render:!0,defaultProps:!0,displayName:!0,propTypes:!0},hd={$$typeof:!0,compare:!0,defaultProps:!0,displayName:!0,propTypes:!0,type:!0},Ks={};Ks[Ys.ForwardRef]=W2;Ks[Ys.Memo]=hd;function m1(e){return Ys.isMemo(e)?hd:Ks[e.$$typeof]||U2}var G2=Object.defineProperty,Q2=Object.getOwnPropertyNames,g1=Object.getOwnPropertySymbols,Y2=Object.getOwnPropertyDescriptor,K2=Object.getPrototypeOf,v1=Object.prototype;function md(e,t,n){if(typeof t!="string"){if(v1){var r=K2(t);r&&r!==v1&&md(e,r,n)}var i=Q2(t);g1&&(i=i.concat(g1(t)));for(var o=m1(e),l=m1(t),s=0;s<i.length;++s){var u=i[s];if(!V2[u]&&!(n&&n[u])&&!(l&&l[u])&&!(o&&o[u])){var c=Y2(t,u);try{G2(e,u,c)}catch{}}}}return e}var Z2=md;function gt(){return(gt=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var r in n)Object.prototype.hasOwnProperty.call(n,r)&&(e[r]=n[r])}return e}).apply(this,arguments)}var y1=function(e,t){for(var n=[e[0]],r=0,i=t.length;r<i;r+=1)n.push(t[r],e[r+1]);return n},Fa=function(e){return e!==null&&typeof e=="object"&&(e.toString?e.toString():Object.prototype.toString.call(e))==="[object Object]"&&!Bo.exports.typeOf(e)},Co=Object.freeze([]),en=Object.freeze({});function ir(e){return typeof e=="function"}function w1(e){return e.displayName||e.name||"Component"}function Zs(e){return e&&typeof e.styledComponentId=="string"}var or=typeof process!="undefined"&&process.env!==void 0&&({}.REACT_APP_SC_ATTR||{}.SC_ATTR)||"data-styled",Xs=typeof window!="undefined"&&"HTMLElement"in window,X2=Boolean(typeof SC_DISABLE_SPEEDY=="boolean"?SC_DISABLE_SPEEDY:typeof process!="undefined"&&process.env!==void 0&&({}.REACT_APP_SC_DISABLE_SPEEDY!==void 0&&{}.REACT_APP_SC_DISABLE_SPEEDY!==""?{}.REACT_APP_SC_DISABLE_SPEEDY!=="false"&&{}.REACT_APP_SC_DISABLE_SPEEDY:{}.SC_DISABLE_SPEEDY!==void 0&&{}.SC_DISABLE_SPEEDY!==""?{}.SC_DISABLE_SPEEDY!=="false"&&{}.SC_DISABLE_SPEEDY:!1)),J2={};function kn(e){for(var t=arguments.length,n=new Array(t>1?t-1:0),r=1;r<t;r++)n[r-1]=arguments[r];throw new Error("An error occurred. See https://git.io/JUIaE#"+e+" for more information."+(n.length>0?" Args: "+n.join(", "):""))}var q2=function(){function e(n){this.groupSizes=new Uint32Array(512),this.length=512,this.tag=n}var t=e.prototype;return t.indexOfGroup=function(n){for(var r=0,i=0;i<n;i++)r+=this.groupSizes[i];return r},t.insertRules=function(n,r){if(n>=this.groupSizes.length){for(var i=this.groupSizes,o=i.length,l=o;n>=l;)(l<<=1)<0&&kn(16,""+n);this.groupSizes=new Uint32Array(l),this.groupSizes.set(i),this.length=l;for(var s=o;s<l;s++)this.groupSizes[s]=0}for(var u=this.indexOfGroup(n+1),c=0,p=r.length;c<p;c++)this.tag.insertRule(u,r[c])&&(this.groupSizes[n]++,u++)},t.clearGroup=function(n){if(n<this.length){var r=this.groupSizes[n],i=this.indexOfGroup(n),o=i+r;this.groupSizes[n]=0;for(var l=i;l<o;l++)this.tag.deleteRule(i)}},t.getGroup=function(n){var r="";if(n>=this.length||this.groupSizes[n]===0)return r;for(var i=this.groupSizes[n],o=this.indexOfGroup(n),l=o+i,s=o;s<l;s++)r+=this.tag.getRule(s)+`/*!sc*/
`;return r},e}(),Gi=new Map,ko=new Map,Fr=1,_i=function(e){if(Gi.has(e))return Gi.get(e);for(;ko.has(Fr);)Fr++;var t=Fr++;return Gi.set(e,t),ko.set(t,e),t},ep=function(e){return ko.get(e)},tp=function(e,t){t>=Fr&&(Fr=t+1),Gi.set(e,t),ko.set(t,e)},np="style["+or+'][data-styled-version="5.3.9"]',rp=new RegExp("^"+or+'\\.g(\\d+)\\[id="([\\w\\d-]+)"\\].*?"([^"]*)'),ip=function(e,t,n){for(var r,i=n.split(","),o=0,l=i.length;o<l;o++)(r=i[o])&&e.registerName(t,r)},op=function(e,t){for(var n=(t.textContent||"").split(`/*!sc*/
`),r=[],i=0,o=n.length;i<o;i++){var l=n[i].trim();if(l){var s=l.match(rp);if(s){var u=0|parseInt(s[1],10),c=s[2];u!==0&&(tp(c,u),ip(e,c,s[3]),e.getTag().insertRules(u,r)),r.length=0}else r.push(l)}}},lp=function(){return typeof __webpack_nonce__!="undefined"?__webpack_nonce__:null},gd=function(e){var t=document.head,n=e||t,r=document.createElement("style"),i=function(s){for(var u=s.childNodes,c=u.length;c>=0;c--){var p=u[c];if(p&&p.nodeType===1&&p.hasAttribute(or))return p}}(n),o=i!==void 0?i.nextSibling:null;r.setAttribute(or,"active"),r.setAttribute("data-styled-version","5.3.9");var l=lp();return l&&r.setAttribute("nonce",l),n.insertBefore(r,o),r},ap=function(){function e(n){var r=this.element=gd(n);r.appendChild(document.createTextNode("")),this.sheet=function(i){if(i.sheet)return i.sheet;for(var o=document.styleSheets,l=0,s=o.length;l<s;l++){var u=o[l];if(u.ownerNode===i)return u}kn(17)}(r),this.length=0}var t=e.prototype;return t.insertRule=function(n,r){try{return this.sheet.insertRule(r,n),this.length++,!0}catch{return!1}},t.deleteRule=function(n){this.sheet.deleteRule(n),this.length--},t.getRule=function(n){var r=this.sheet.cssRules[n];return r!==void 0&&typeof r.cssText=="string"?r.cssText:""},e}(),sp=function(){function e(n){var r=this.element=gd(n);this.nodes=r.childNodes,this.length=0}var t=e.prototype;return t.insertRule=function(n,r){if(n<=this.length&&n>=0){var i=document.createTextNode(r),o=this.nodes[n];return this.element.insertBefore(i,o||null),this.length++,!0}return!1},t.deleteRule=function(n){this.element.removeChild(this.nodes[n]),this.length--},t.getRule=function(n){return n<this.length?this.nodes[n].textContent:""},e}(),up=function(){function e(n){this.rules=[],this.length=0}var t=e.prototype;return t.insertRule=function(n,r){return n<=this.length&&(this.rules.splice(n,0,r),this.length++,!0)},t.deleteRule=function(n){this.rules.splice(n,1),this.length--},t.getRule=function(n){return n<this.length?this.rules[n]:""},e}(),x1=Xs,cp={isServer:!Xs,useCSSOMInjection:!X2},So=function(){function e(n,r,i){n===void 0&&(n=en),r===void 0&&(r={}),this.options=gt({},cp,{},n),this.gs=r,this.names=new Map(i),this.server=!!n.isServer,!this.server&&Xs&&x1&&(x1=!1,function(o){for(var l=document.querySelectorAll(np),s=0,u=l.length;s<u;s++){var c=l[s];c&&c.getAttribute(or)!=="active"&&(op(o,c),c.parentNode&&c.parentNode.removeChild(c))}}(this))}e.registerId=function(n){return _i(n)};var t=e.prototype;return t.reconstructWithOptions=function(n,r){return r===void 0&&(r=!0),new e(gt({},this.options,{},n),this.gs,r&&this.names||void 0)},t.allocateGSInstance=function(n){return this.gs[n]=(this.gs[n]||0)+1},t.getTag=function(){return this.tag||(this.tag=(i=(r=this.options).isServer,o=r.useCSSOMInjection,l=r.target,n=i?new up(l):o?new ap(l):new sp(l),new q2(n)));var n,r,i,o,l},t.hasNameForId=function(n,r){return this.names.has(n)&&this.names.get(n).has(r)},t.registerName=function(n,r){if(_i(n),this.names.has(n))this.names.get(n).add(r);else{var i=new Set;i.add(r),this.names.set(n,i)}},t.insertRules=function(n,r,i){this.registerName(n,r),this.getTag().insertRules(_i(n),i)},t.clearNames=function(n){this.names.has(n)&&this.names.get(n).clear()},t.clearRules=function(n){this.getTag().clearGroup(_i(n)),this.clearNames(n)},t.clearTag=function(){this.tag=void 0},t.toString=function(){return function(n){for(var r=n.getTag(),i=r.length,o="",l=0;l<i;l++){var s=ep(l);if(s!==void 0){var u=n.names.get(s),c=r.getGroup(l);if(u&&c&&u.size){var p=or+".g"+l+'[id="'+s+'"]',g="";u!==void 0&&u.forEach(function(m){m.length>0&&(g+=m+",")}),o+=""+c+p+'{content:"'+g+`"}/*!sc*/
`}}}return o}(this)},e}(),dp=/(a)(d)/gi,C1=function(e){return String.fromCharCode(e+(e>25?39:97))};function ja(e){var t,n="";for(t=Math.abs(e);t>52;t=t/52|0)n=C1(t%52)+n;return(C1(t%52)+n).replace(dp,"$1-$2")}var Vn=function(e,t){for(var n=t.length;n;)e=33*e^t.charCodeAt(--n);return e},vd=function(e){return Vn(5381,e)};function yd(e){for(var t=0;t<e.length;t+=1){var n=e[t];if(ir(n)&&!Zs(n))return!1}return!0}var fp=vd("5.3.9"),pp=function(){function e(t,n,r){this.rules=t,this.staticRulesId="",this.isStatic=(r===void 0||r.isStatic)&&yd(t),this.componentId=n,this.baseHash=Vn(fp,n),this.baseStyle=r,So.registerId(n)}return e.prototype.generateAndInjectStyles=function(t,n,r){var i=this.componentId,o=[];if(this.baseStyle&&o.push(this.baseStyle.generateAndInjectStyles(t,n,r)),this.isStatic&&!r.hash)if(this.staticRulesId&&n.hasNameForId(i,this.staticRulesId))o.push(this.staticRulesId);else{var l=Sn(this.rules,t,n,r).join(""),s=ja(Vn(this.baseHash,l)>>>0);if(!n.hasNameForId(i,s)){var u=r(l,"."+s,void 0,i);n.insertRules(i,s,u)}o.push(s),this.staticRulesId=s}else{for(var c=this.rules.length,p=Vn(this.baseHash,r.hash),g="",m=0;m<c;m++){var C=this.rules[m];if(typeof C=="string")g+=C;else if(C){var y=Sn(C,t,n,r),w=Array.isArray(y)?y.join(""):y;p=Vn(p,w+m),g+=w}}if(g){var P=ja(p>>>0);if(!n.hasNameForId(i,P)){var f=r(g,"."+P,void 0,i);n.insertRules(i,P,f)}o.push(P)}}return o.join(" ")},e}(),hp=/^\s*\/\/.*$/gm,mp=[":","[",".","#"];function gp(e){var t,n,r,i,o=e===void 0?en:e,l=o.options,s=l===void 0?en:l,u=o.plugins,c=u===void 0?Co:u,p=new j2(s),g=[],m=function(w){function P(f){if(f)try{w(f+"}")}catch{}}return function(f,d,h,k,z,_,M,b,V,I){switch(f){case 1:if(V===0&&d.charCodeAt(0)===64)return w(d+";"),"";break;case 2:if(b===0)return d+"/*|*/";break;case 3:switch(b){case 102:case 112:return w(h[0]+d),"";default:return d+(I===0?"/*|*/":"")}case-2:d.split("/*|*/}").forEach(P)}}}(function(w){g.push(w)}),C=function(w,P,f){return P===0&&mp.indexOf(f[n.length])!==-1||f.match(i)?w:"."+t};function y(w,P,f,d){d===void 0&&(d="&");var h=w.replace(hp,""),k=P&&f?f+" "+P+" { "+h+" }":h;return t=d,n=P,r=new RegExp("\\"+n+"\\b","g"),i=new RegExp("(\\"+n+"\\b){2,}"),p(f||!P?"":P,k)}return p.use([].concat(c,[function(w,P,f){w===2&&f.length&&f[0].lastIndexOf(n)>0&&(f[0]=f[0].replace(r,C))},m,function(w){if(w===-2){var P=g;return g=[],P}}])),y.hash=c.length?c.reduce(function(w,P){return P.name||kn(15),Vn(w,P.name)},5381).toString():"",y}var wd=Y.createContext();wd.Consumer;var xd=Y.createContext(),vp=(xd.Consumer,new So),Da=gp();function Cd(){return x.exports.useContext(wd)||vp}function kd(){return x.exports.useContext(xd)||Da}var yp=function(){function e(t,n){var r=this;this.inject=function(i,o){o===void 0&&(o=Da);var l=r.name+o.hash;i.hasNameForId(r.id,l)||i.insertRules(r.id,l,o(r.rules,l,"@keyframes"))},this.toString=function(){return kn(12,String(r.name))},this.name=t,this.id="sc-keyframes-"+t,this.rules=n}return e.prototype.getName=function(t){return t===void 0&&(t=Da),this.name+t.hash},e}(),wp=/([A-Z])/,xp=/([A-Z])/g,Cp=/^ms-/,kp=function(e){return"-"+e.toLowerCase()};function k1(e){return wp.test(e)?e.replace(xp,kp).replace(Cp,"-ms-"):e}var S1=function(e){return e==null||e===!1||e===""};function Sn(e,t,n,r){if(Array.isArray(e)){for(var i,o=[],l=0,s=e.length;l<s;l+=1)(i=Sn(e[l],t,n,r))!==""&&(Array.isArray(i)?o.push.apply(o,i):o.push(i));return o}if(S1(e))return"";if(Zs(e))return"."+e.styledComponentId;if(ir(e)){if(typeof(c=e)!="function"||c.prototype&&c.prototype.isReactComponent||!t)return e;var u=e(t);return Sn(u,t,n,r)}var c;return e instanceof yp?n?(e.inject(n,r),e.getName(r)):e:Fa(e)?function p(g,m){var C,y,w=[];for(var P in g)g.hasOwnProperty(P)&&!S1(g[P])&&(Array.isArray(g[P])&&g[P].isCss||ir(g[P])?w.push(k1(P)+":",g[P],";"):Fa(g[P])?w.push.apply(w,p(g[P],P)):w.push(k1(P)+": "+(C=P,(y=g[P])==null||typeof y=="boolean"||y===""?"":typeof y!="number"||y===0||C in D2?String(y).trim():y+"px")+";"));return m?[m+" {"].concat(w,["}"]):w}(e):e.toString()}var E1=function(e){return Array.isArray(e)&&(e.isCss=!0),e};function Sd(e){for(var t=arguments.length,n=new Array(t>1?t-1:0),r=1;r<t;r++)n[r-1]=arguments[r];return ir(e)||Fa(e)?E1(Sn(y1(Co,[e].concat(n)))):n.length===0&&e.length===1&&typeof e[0]=="string"?e:E1(Sn(y1(e,n)))}var Ed=function(e,t,n){return n===void 0&&(n=en),e.theme!==n.theme&&e.theme||t||n.theme},Sp=/[!"#$%&'()*+,./:;<=>?@[\\\]^`{|}~-]+/g,Ep=/(^-|-$)/g;function $l(e){return e.replace(Sp,"-").replace(Ep,"")}var Pd=function(e){return ja(vd(e)>>>0)};function Mi(e){return typeof e=="string"&&!0}var Ba=function(e){return typeof e=="function"||typeof e=="object"&&e!==null&&!Array.isArray(e)},Pp=function(e){return e!=="__proto__"&&e!=="constructor"&&e!=="prototype"};function zp(e,t,n){var r=e[n];Ba(t)&&Ba(r)?zd(r,t):e[n]=t}function zd(e){for(var t=arguments.length,n=new Array(t>1?t-1:0),r=1;r<t;r++)n[r-1]=arguments[r];for(var i=0,o=n;i<o.length;i++){var l=o[i];if(Ba(l))for(var s in l)Pp(s)&&zp(e,l[s],s)}return e}var ni=Y.createContext();ni.Consumer;function Rp(e){var t=x.exports.useContext(ni),n=x.exports.useMemo(function(){return function(r,i){if(!r)return kn(14);if(ir(r)){var o=r(i);return o}return Array.isArray(r)||typeof r!="object"?kn(8):i?gt({},i,{},r):r}(e.theme,t)},[e.theme,t]);return e.children?Y.createElement(ni.Provider,{value:n},e.children):null}var Il={};function Rd(e,t,n){var r=Zs(e),i=!Mi(e),o=t.attrs,l=o===void 0?Co:o,s=t.componentId,u=s===void 0?function(d,h){var k=typeof d!="string"?"sc":$l(d);Il[k]=(Il[k]||0)+1;var z=k+"-"+Pd("5.3.9"+k+Il[k]);return h?h+"-"+z:z}(t.displayName,t.parentComponentId):s,c=t.displayName,p=c===void 0?function(d){return Mi(d)?"styled."+d:"Styled("+w1(d)+")"}(e):c,g=t.displayName&&t.componentId?$l(t.displayName)+"-"+t.componentId:t.componentId||u,m=r&&e.attrs?Array.prototype.concat(e.attrs,l).filter(Boolean):l,C=t.shouldForwardProp;r&&e.shouldForwardProp&&(C=t.shouldForwardProp?function(d,h,k){return e.shouldForwardProp(d,h,k)&&t.shouldForwardProp(d,h,k)}:e.shouldForwardProp);var y,w=new pp(n,g,r?e.componentStyle:void 0),P=w.isStatic&&l.length===0,f=function(d,h){return function(k,z,_,M){var b=k.attrs,V=k.componentStyle,I=k.defaultProps,H=k.foldedComponentIds,Q=k.shouldForwardProp,ne=k.styledComponentId,me=k.target,be=function(D,S,G){D===void 0&&(D=en);var N=gt({},S,{theme:D}),de={};return G.forEach(function(X){var q,U,Ee,Ue=X;for(q in ir(Ue)&&(Ue=Ue(N)),Ue)N[q]=de[q]=q==="className"?(U=de[q],Ee=Ue[q],U&&Ee?U+" "+Ee:U||Ee):Ue[q]}),[N,de]}(Ed(z,x.exports.useContext(ni),I)||en,z,b),Pt=be[0],Fe=be[1],L=function(D,S,G,N){var de=Cd(),X=kd(),q=S?D.generateAndInjectStyles(en,de,X):D.generateAndInjectStyles(G,de,X);return q}(V,M,Pt),F=_,j=Fe.$as||z.$as||Fe.as||z.as||me,re=Mi(j),T=Fe!==z?gt({},z,{},Fe):z,O={};for(var A in T)A[0]!=="$"&&A!=="as"&&(A==="forwardedAs"?O.as=T[A]:(Q?Q(A,h1,j):!re||h1(A))&&(O[A]=T[A]));return z.style&&Fe.style!==z.style&&(O.style=gt({},z.style,{},Fe.style)),O.className=Array.prototype.concat(H,ne,L!==ne?L:null,z.className,Fe.className).filter(Boolean).join(" "),O.ref=F,x.exports.createElement(j,O)}(y,d,h,P)};return f.displayName=p,(y=Y.forwardRef(f)).attrs=m,y.componentStyle=w,y.displayName=p,y.shouldForwardProp=C,y.foldedComponentIds=r?Array.prototype.concat(e.foldedComponentIds,e.styledComponentId):Co,y.styledComponentId=g,y.target=r?e.target:e,y.withComponent=function(d){var h=t.componentId,k=function(_,M){if(_==null)return{};var b,V,I={},H=Object.keys(_);for(V=0;V<H.length;V++)b=H[V],M.indexOf(b)>=0||(I[b]=_[b]);return I}(t,["componentId"]),z=h&&h+"-"+(Mi(d)?d:$l(w1(d)));return Rd(d,gt({},k,{attrs:m,componentId:z}),n)},Object.defineProperty(y,"defaultProps",{get:function(){return this._foldedDefaultProps},set:function(d){this._foldedDefaultProps=r?zd({},e.defaultProps,d):d}}),Object.defineProperty(y,"toString",{value:function(){return"."+y.styledComponentId}}),i&&Z2(y,e,{attrs:!0,componentStyle:!0,displayName:!0,foldedComponentIds:!0,shouldForwardProp:!0,styledComponentId:!0,target:!0,withComponent:!0}),y}var Ha=function(e){return function t(n,r,i){if(i===void 0&&(i=en),!Bo.exports.isValidElementType(r))return kn(1,String(r));var o=function(){return n(r,i,Sd.apply(void 0,arguments))};return o.withConfig=function(l){return t(n,r,gt({},i,{},l))},o.attrs=function(l){return t(n,r,gt({},i,{attrs:Array.prototype.concat(i.attrs,l).filter(Boolean)}))},o}(Rd,e)};["a","abbr","address","area","article","aside","audio","b","base","bdi","bdo","big","blockquote","body","br","button","canvas","caption","cite","code","col","colgroup","data","datalist","dd","del","details","dfn","dialog","div","dl","dt","em","embed","fieldset","figcaption","figure","footer","form","h1","h2","h3","h4","h5","h6","head","header","hgroup","hr","html","i","iframe","img","input","ins","kbd","keygen","label","legend","li","link","main","map","mark","marquee","menu","menuitem","meta","meter","nav","noscript","object","ol","optgroup","option","output","p","param","picture","pre","progress","q","rp","rt","ruby","s","samp","script","section","select","small","source","span","strong","style","sub","summary","sup","table","tbody","td","textarea","tfoot","th","thead","time","title","tr","track","u","ul","var","video","wbr","circle","clipPath","defs","ellipse","foreignObject","g","image","line","linearGradient","marker","mask","path","pattern","polygon","polyline","radialGradient","rect","stop","svg","text","textPath","tspan"].forEach(function(e){Ha[e]=Ha(e)});var Lp=function(){function e(n,r){this.rules=n,this.componentId=r,this.isStatic=yd(n),So.registerId(this.componentId+1)}var t=e.prototype;return t.createStyles=function(n,r,i,o){var l=o(Sn(this.rules,r,i,o).join(""),""),s=this.componentId+n;i.insertRules(s,s,l)},t.removeStyles=function(n,r){r.clearRules(this.componentId+n)},t.renderStyles=function(n,r,i,o){n>2&&So.registerId(this.componentId+n),this.removeStyles(n,i),this.createStyles(n,r,i,o)},e}();function Np(e){for(var t=arguments.length,n=new Array(t>1?t-1:0),r=1;r<t;r++)n[r-1]=arguments[r];var i=Sd.apply(void 0,[e].concat(n)),o="sc-global-"+Pd(JSON.stringify(i)),l=new Lp(i,o);function s(c){var p=Cd(),g=kd(),m=x.exports.useContext(ni),C=x.exports.useRef(p.allocateGSInstance(o)).current;return p.server&&u(C,c,p,m,g),x.exports.useLayoutEffect(function(){if(!p.server)return u(C,c,p,m,g),function(){return l.removeStyles(C,p)}},[C,c,p,m,g]),null}function u(c,p,g,m,C){if(l.isStatic)l.renderStyles(c,J2,g,C);else{var y=gt({},p,{theme:Ed(p,m,s.defaultProps)});l.renderStyles(c,y,g,C)}}return Y.memo(s)}var E=Ha;const lr=()=>!window.invokeNative,Tp=()=>{};async function We(e,t,n,r="nui-frame-app"){const i={method:"post",headers:{"Content-Type":"application/json; charset=UTF-8"},body:JSON.stringify(t)};if(lr()&&n)return n;const o=window.GetParentResourceName?window.GetParentResourceName():r;return await(await fetch(`https://${o}/${e}`,i)).json()}const P1={imagesPath:"default",colors:{main:{50:"#fff7da",100:"#ffe7ad",200:"#ffd77d",300:"#ffc74b",400:"#ffb71a",500:"#e69d00",600:"#b37a00",700:"#815700",800:"#4e3400",900:"#1e1000"},"main-opacity":{50:"rgba(255, 184, 29, 0)",100:"rgba(255, 184, 29, 0.1)",200:"rgba(255, 184, 29, 0.2)",300:"rgba(255, 184, 29, 0.3)",400:"rgba(255, 184, 29, 0.4)",500:"rgba(255, 184, 29, 0.5)",600:"rgba(255, 184, 29, 0.6)",700:"rgba(255, 184, 29, 0.7)",800:"rgba(255, 184, 29, 0.8)",900:"rgba(255, 184, 29, 0.9)"},red:{50:"#ffe1e1",100:"#ffb1b1",200:"#ff7f7f",300:"#ff4c4c",400:"#ff1a1a",500:"#e60000",600:"#b40000",700:"#810000",800:"#500000",900:"#210000"},"red-opacity":{50:"rgba(255, 29, 29, 0);",100:"rgba(255, 29, 29, 0.1);",200:"rgba(255, 29, 29, 0.2);",300:"rgba(255, 29, 29, 0.3);",400:"rgba(255, 29, 29, 0.4);",500:"rgba(255, 29, 29, 0.5);",600:"rgba(255, 29, 29, 0.6);",700:"rgba(255, 29, 29, 0.7);",800:"rgba(255, 29, 29, 0.8);",900:"rgba(255, 29, 29, 0.9);"},white:{50:"#f2f2f2",100:"#d9d9d9",200:"#bfbfbf",300:"#a6a6a6",400:"#8c8c8c",500:"#737373",600:"#595959",700:"#404040",800:"#262626",900:"#0d0d0d"},background:{50:"#f2f2f2",100:"#d9d9d9",200:"#bfbfbf",300:"#a6a6a6",400:"#8c8c8c",500:"#737373",600:"#595959",700:"#404040",800:"#262626",900:"#0d0d0d"}},borders:"",breakpoints:"",colorSchemes:"",fonts:"",fontSizes:"",fontWeights:"",layerStyles:"",letterSpacings:"",lineHeights:"",radii:"",shadows:"",sizes:"",space:"",textStyles:"",zIndices:""};var Ld={exports:{}},Jo={};/**
 * @license React
 * react-jsx-runtime.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */var bp=Y,_p=Symbol.for("react.element"),Mp=Symbol.for("react.fragment"),Op=Object.prototype.hasOwnProperty,Ap=bp.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner,$p={key:!0,ref:!0,__self:!0,__source:!0};function Nd(e,t,n){var r,i={},o=null,l=null;n!==void 0&&(o=""+n),t.key!==void 0&&(o=""+t.key),t.ref!==void 0&&(l=t.ref);for(r in t)Op.call(t,r)&&!$p.hasOwnProperty(r)&&(i[r]=t[r]);if(e&&e.defaultProps)for(r in t=e.defaultProps,t)i[r]===void 0&&(i[r]=t[r]);return{$$typeof:_p,type:e,key:o,ref:l,props:i,_owner:Ap.current}}Jo.Fragment=Mp;Jo.jsx=Nd;Jo.jsxs=Nd;Ld.exports=Jo;const z1=Ld.exports.jsx,Ip=x.exports.createContext(null);function Fp({children:e,alternativeResource:t}){const[n,r]=x.exports.useState(P1);return x.exports.useEffect(()=>{We("getTheme",{},P1,t).then(i=>{r(i)})},[]),z1(Ip.Provider,{value:{theme:n,setTheme:r},children:z1(Rp,{theme:n,children:e})})}const we=(e,t)=>{const n=x.exports.useRef(Tp);x.exports.useEffect(()=>{n.current=t},[t]),x.exports.useEffect(()=>{const r=i=>{const{action:o,data:l}=i.data;n.current&&o===e&&n.current(l)};return window.addEventListener("message",r),()=>{window.removeEventListener("message",r)}},[e])};var qo={exports:{}},el={};/**
 * @license React
 * react-jsx-runtime.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */var jp=x.exports,Dp=Symbol.for("react.element"),Bp=Symbol.for("react.fragment"),Hp=Object.prototype.hasOwnProperty,Up=jp.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner,Vp={key:!0,ref:!0,__self:!0,__source:!0};function Td(e,t,n){var r,i={},o=null,l=null;n!==void 0&&(o=""+n),t.key!==void 0&&(o=""+t.key),t.ref!==void 0&&(l=t.ref);for(r in t)Hp.call(t,r)&&!Vp.hasOwnProperty(r)&&(i[r]=t[r]);if(e&&e.defaultProps)for(r in t=e.defaultProps,t)i[r]===void 0&&(i[r]=t[r]);return{$$typeof:Dp,type:e,key:o,ref:l,props:i,_owner:Up.current}}el.Fragment=Bp;el.jsx=Td;el.jsxs=Td;qo.exports=el;const a=qo.exports.jsx,v=qo.exports.jsxs,tl=qo.exports.Fragment,Wp=x.exports.createContext(null),Gp=({children:e})=>{const[t,n]=x.exports.useState(!1);return we("setVisible",n),x.exports.useEffect(()=>{if(!t)return;const r=i=>{["Escape"].includes(i.code)&&(lr()?n(!t):We("hideFrame"))};return window.addEventListener("keydown",r),()=>window.removeEventListener("keydown",r)},[t]),x.exports.useEffect(()=>{lr()&&n(!0)},[]),a(Wp.Provider,{value:{visible:t,setVisible:n},children:a("div",{style:{visibility:t?"visible":"hidden",height:"100%"},children:e})})};var Qp=Np`
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    user-select: none;
    outline: 0;
    
    -webkit-font-smoothing: antialiased;
  }
  
  body {
    color: #FFF;
    -webkit-font-smoothing: antialiased;
    overflow-y: hidden;
    overflow-x: hidden;
    user-select: none;
    background: ${lr()?"green":"none"};
  }
  
  body, input, button {
    font-family: 'Poppins', sans-serif;
    font-size: 16px;
    user-select: none;
  }
  
  h1, h2, h3, h4, h5, h6, strong {
    font-weight: 500;
    user-select: none;
  }
  
  button {
    cursor: pointer;
  }
  
  :root {
    font-size: 16px;
  }
  
  *
  ::-webkit-scrollbar {
      width: 0.5vw;
  }

  ::-webkit-scrollbar-thumb {
      background: radial-gradient(87.22% 84.84% at 17.04% 12.91%, #F20A45 0%, #69510C 99%);
      border-radius: 100vw;
      overflow: hidden;
  }

  ::-webkit-scrollbar-track {
      background: radial-gradient(87.22% 84.84% at 17.04% 12.91%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.03) 100%);
      border-radius: 100vw;
      overflow: hidden;
  }

  @media screen and (max-width: 800px), screen and (max-height: 600px) {
    :root {
      font-size: 0.3rem;
    }
  }
  @media screen and (min-width: 800px) and (min-height: 600px) {
    :root {
      font-size: 0.425rem;
    }
  }
  @media screen and (min-width: 1000px) and (min-height: 700px) {
    :root {
      font-size: 0.55rem;
    }
  }
  @media screen and (min-width: 1100px) and (min-height: 700px) {
    :root {
    font-size: 0.6rem;
    }
  }
  @media screen and (min-width: 1300px) and (min-height: 700px) {
    :root {
      font-size: 0.7rem;
    }
  }
  @media screen and (min-width: 1400px) and (min-height: 700px) {
    :root {
      font-size: 0.75rem;
    }
  }
  @media screen and (min-width: 1600px) and (min-height: 800px) {
    :root {
      font-size: 0.8rem;
    }
  }
  @media screen and (min-width: 1750px) and (min-height: 900px) {
    :root {
      font-size: 0.9rem;
    }
  }
  @media screen and (min-width: 1850px) and (min-height: 1000px) {
    :root {
      font-size: 1rem;
    }
  }
`,Yp="./assets/santa-pvp.90c2f434.png";const Kp=E.div`
  position: absolute;
  left: 1.5rem;
  top: -2%;
  background: url(${Yp}) no-repeat center;
  background-size: 100% 100%;
  width: 24rem;
  height: 16rem;
`;/**
 * @remix-run/router v1.4.0
 *
 * Copyright (c) Remix Software Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.md file in the root directory of this source tree.
 *
 * @license MIT
 */function ri(){return ri=Object.assign?Object.assign.bind():function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var r in n)Object.prototype.hasOwnProperty.call(n,r)&&(e[r]=n[r])}return e},ri.apply(this,arguments)}var Wt;(function(e){e.Pop="POP",e.Push="PUSH",e.Replace="REPLACE"})(Wt||(Wt={}));const R1="popstate";function Zp(e){e===void 0&&(e={});function t(r,i){let{pathname:o,search:l,hash:s}=r.location;return Ua("",{pathname:o,search:l,hash:s},i.state&&i.state.usr||null,i.state&&i.state.key||"default")}function n(r,i){return typeof i=="string"?i:Eo(i)}return Jp(t,n,null,e)}function ve(e,t){if(e===!1||e===null||typeof e=="undefined")throw new Error(t)}function Js(e,t){if(!e){typeof console!="undefined"&&console.warn(t);try{throw new Error(t)}catch{}}}function Xp(){return Math.random().toString(36).substr(2,8)}function L1(e,t){return{usr:e.state,key:e.key,idx:t}}function Ua(e,t,n,r){return n===void 0&&(n=null),ri({pathname:typeof e=="string"?e:e.pathname,search:"",hash:""},typeof t=="string"?cr(t):t,{state:n,key:t&&t.key||r||Xp()})}function Eo(e){let{pathname:t="/",search:n="",hash:r=""}=e;return n&&n!=="?"&&(t+=n.charAt(0)==="?"?n:"?"+n),r&&r!=="#"&&(t+=r.charAt(0)==="#"?r:"#"+r),t}function cr(e){let t={};if(e){let n=e.indexOf("#");n>=0&&(t.hash=e.substr(n),e=e.substr(0,n));let r=e.indexOf("?");r>=0&&(t.search=e.substr(r),e=e.substr(0,r)),e&&(t.pathname=e)}return t}function Jp(e,t,n,r){r===void 0&&(r={});let{window:i=document.defaultView,v5Compat:o=!1}=r,l=i.history,s=Wt.Pop,u=null,c=p();c==null&&(c=0,l.replaceState(ri({},l.state,{idx:c}),""));function p(){return(l.state||{idx:null}).idx}function g(){s=Wt.Pop;let P=p(),f=P==null?null:P-c;c=P,u&&u({action:s,location:w.location,delta:f})}function m(P,f){s=Wt.Push;let d=Ua(w.location,P,f);n&&n(d,P),c=p()+1;let h=L1(d,c),k=w.createHref(d);try{l.pushState(h,"",k)}catch{i.location.assign(k)}o&&u&&u({action:s,location:w.location,delta:1})}function C(P,f){s=Wt.Replace;let d=Ua(w.location,P,f);n&&n(d,P),c=p();let h=L1(d,c),k=w.createHref(d);l.replaceState(h,"",k),o&&u&&u({action:s,location:w.location,delta:0})}function y(P){let f=i.location.origin!=="null"?i.location.origin:i.location.href,d=typeof P=="string"?P:Eo(P);return ve(f,"No window.location.(origin|href) available to create URL for href: "+d),new URL(d,f)}let w={get action(){return s},get location(){return e(i,l)},listen(P){if(u)throw new Error("A history only accepts one active listener");return i.addEventListener(R1,g),u=P,()=>{i.removeEventListener(R1,g),u=null}},createHref(P){return t(i,P)},createURL:y,encodeLocation(P){let f=y(P);return{pathname:f.pathname,search:f.search,hash:f.hash}},push:m,replace:C,go(P){return l.go(P)}};return w}var N1;(function(e){e.data="data",e.deferred="deferred",e.redirect="redirect",e.error="error"})(N1||(N1={}));function qp(e,t,n){n===void 0&&(n="/");let r=typeof t=="string"?cr(t):t,i=qs(r.pathname||"/",n);if(i==null)return null;let o=bd(e);eh(o);let l=null;for(let s=0;l==null&&s<o.length;++s)l=uh(o[s],fh(i));return l}function bd(e,t,n,r){t===void 0&&(t=[]),n===void 0&&(n=[]),r===void 0&&(r="");let i=(o,l,s)=>{let u={relativePath:s===void 0?o.path||"":s,caseSensitive:o.caseSensitive===!0,childrenIndex:l,route:o};u.relativePath.startsWith("/")&&(ve(u.relativePath.startsWith(r),'Absolute route path "'+u.relativePath+'" nested under path '+('"'+r+'" is not valid. An absolute child route path ')+"must start with the combined path of all its parent routes."),u.relativePath=u.relativePath.slice(r.length));let c=tn([r,u.relativePath]),p=n.concat(u);o.children&&o.children.length>0&&(ve(o.index!==!0,"Index routes must not have child routes. Please remove "+('all child routes from route path "'+c+'".')),bd(o.children,t,p,c)),!(o.path==null&&!o.index)&&t.push({path:c,score:ah(c,o.index),routesMeta:p})};return e.forEach((o,l)=>{var s;if(o.path===""||!((s=o.path)!=null&&s.includes("?")))i(o,l);else for(let u of _d(o.path))i(o,l,u)}),t}function _d(e){let t=e.split("/");if(t.length===0)return[];let[n,...r]=t,i=n.endsWith("?"),o=n.replace(/\?$/,"");if(r.length===0)return i?[o,""]:[o];let l=_d(r.join("/")),s=[];return s.push(...l.map(u=>u===""?o:[o,u].join("/"))),i&&s.push(...l),s.map(u=>e.startsWith("/")&&u===""?"/":u)}function eh(e){e.sort((t,n)=>t.score!==n.score?n.score-t.score:sh(t.routesMeta.map(r=>r.childrenIndex),n.routesMeta.map(r=>r.childrenIndex)))}const th=/^:\w+$/,nh=3,rh=2,ih=1,oh=10,lh=-2,T1=e=>e==="*";function ah(e,t){let n=e.split("/"),r=n.length;return n.some(T1)&&(r+=lh),t&&(r+=rh),n.filter(i=>!T1(i)).reduce((i,o)=>i+(th.test(o)?nh:o===""?ih:oh),r)}function sh(e,t){return e.length===t.length&&e.slice(0,-1).every((r,i)=>r===t[i])?e[e.length-1]-t[t.length-1]:0}function uh(e,t){let{routesMeta:n}=e,r={},i="/",o=[];for(let l=0;l<n.length;++l){let s=n[l],u=l===n.length-1,c=i==="/"?t:t.slice(i.length)||"/",p=ch({path:s.relativePath,caseSensitive:s.caseSensitive,end:u},c);if(!p)return null;Object.assign(r,p.params);let g=s.route;o.push({params:r,pathname:tn([i,p.pathname]),pathnameBase:gh(tn([i,p.pathnameBase])),route:g}),p.pathnameBase!=="/"&&(i=tn([i,p.pathnameBase]))}return o}function ch(e,t){typeof e=="string"&&(e={path:e,caseSensitive:!1,end:!0});let[n,r]=dh(e.path,e.caseSensitive,e.end),i=t.match(n);if(!i)return null;let o=i[0],l=o.replace(/(.)\/+$/,"$1"),s=i.slice(1);return{params:r.reduce((c,p,g)=>{if(p==="*"){let m=s[g]||"";l=o.slice(0,o.length-m.length).replace(/(.)\/+$/,"$1")}return c[p]=ph(s[g]||"",p),c},{}),pathname:o,pathnameBase:l,pattern:e}}function dh(e,t,n){t===void 0&&(t=!1),n===void 0&&(n=!0),Js(e==="*"||!e.endsWith("*")||e.endsWith("/*"),'Route path "'+e+'" will be treated as if it were '+('"'+e.replace(/\*$/,"/*")+'" because the `*` character must ')+"always follow a `/` in the pattern. To get rid of this warning, "+('please change the route path to "'+e.replace(/\*$/,"/*")+'".'));let r=[],i="^"+e.replace(/\/*\*?$/,"").replace(/^\/*/,"/").replace(/[\\.*+^$?{}|()[\]]/g,"\\$&").replace(/\/:(\w+)/g,(l,s)=>(r.push(s),"/([^\\/]+)"));return e.endsWith("*")?(r.push("*"),i+=e==="*"||e==="/*"?"(.*)$":"(?:\\/(.+)|\\/*)$"):n?i+="\\/*$":e!==""&&e!=="/"&&(i+="(?:(?=\\/|$))"),[new RegExp(i,t?void 0:"i"),r]}function fh(e){try{return decodeURI(e)}catch(t){return Js(!1,'The URL path "'+e+'" could not be decoded because it is is a malformed URL segment. This is probably due to a bad percent '+("encoding ("+t+").")),e}}function ph(e,t){try{return decodeURIComponent(e)}catch(n){return Js(!1,'The value for the URL param "'+t+'" will not be decoded because'+(' the string "'+e+'" is a malformed URL segment. This is probably')+(" due to a bad percent encoding ("+n+").")),e}}function qs(e,t){if(t==="/")return e;if(!e.toLowerCase().startsWith(t.toLowerCase()))return null;let n=t.endsWith("/")?t.length-1:t.length,r=e.charAt(n);return r&&r!=="/"?null:e.slice(n)||"/"}function hh(e,t){t===void 0&&(t="/");let{pathname:n,search:r="",hash:i=""}=typeof e=="string"?cr(e):e;return{pathname:n?n.startsWith("/")?n:mh(n,t):t,search:vh(r),hash:yh(i)}}function mh(e,t){let n=t.replace(/\/+$/,"").split("/");return e.split("/").forEach(i=>{i===".."?n.length>1&&n.pop():i!=="."&&n.push(i)}),n.length>1?n.join("/"):"/"}function Fl(e,t,n,r){return"Cannot include a '"+e+"' character in a manually specified "+("`to."+t+"` field ["+JSON.stringify(r)+"].  Please separate it out to the ")+("`to."+n+"` field. Alternatively you may provide the full path as ")+'a string in <Link to="..."> and the router will parse it for you.'}function Md(e){return e.filter((t,n)=>n===0||t.route.path&&t.route.path.length>0)}function Od(e,t,n,r){r===void 0&&(r=!1);let i;typeof e=="string"?i=cr(e):(i=ri({},e),ve(!i.pathname||!i.pathname.includes("?"),Fl("?","pathname","search",i)),ve(!i.pathname||!i.pathname.includes("#"),Fl("#","pathname","hash",i)),ve(!i.search||!i.search.includes("#"),Fl("#","search","hash",i)));let o=e===""||i.pathname==="",l=o?"/":i.pathname,s;if(r||l==null)s=n;else{let g=t.length-1;if(l.startsWith("..")){let m=l.split("/");for(;m[0]==="..";)m.shift(),g-=1;i.pathname=m.join("/")}s=g>=0?t[g]:"/"}let u=hh(i,s),c=l&&l!=="/"&&l.endsWith("/"),p=(o||l===".")&&n.endsWith("/");return!u.pathname.endsWith("/")&&(c||p)&&(u.pathname+="/"),u}const tn=e=>e.join("/").replace(/\/\/+/g,"/"),gh=e=>e.replace(/\/+$/,"").replace(/^\/*/,"/"),vh=e=>!e||e==="?"?"":e.startsWith("?")?e:"?"+e,yh=e=>!e||e==="#"?"":e.startsWith("#")?e:"#"+e;function wh(e){return e!=null&&typeof e.status=="number"&&typeof e.statusText=="string"&&typeof e.internal=="boolean"&&"data"in e}const xh=["post","put","patch","delete"];[...xh];/**
 * React Router v6.9.0
 *
 * Copyright (c) Remix Software Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.md file in the root directory of this source tree.
 *
 * @license MIT
 */function Ch(e,t){return e===t&&(e!==0||1/e===1/t)||e!==e&&t!==t}const kh=typeof Object.is=="function"?Object.is:Ch,{useState:Sh,useEffect:Eh,useLayoutEffect:Ph,useDebugValue:zh}=Vl;function Rh(e,t,n){const r=t(),[{inst:i},o]=Sh({inst:{value:r,getSnapshot:t}});return Ph(()=>{i.value=r,i.getSnapshot=t,jl(i)&&o({inst:i})},[e,r,t]),Eh(()=>(jl(i)&&o({inst:i}),e(()=>{jl(i)&&o({inst:i})})),[e]),zh(r),r}function jl(e){const t=e.getSnapshot,n=e.value;try{const r=t();return!kh(n,r)}catch{return!0}}function Lh(e,t,n){return t()}const Nh=typeof window!="undefined"&&typeof window.document!="undefined"&&typeof window.document.createElement!="undefined",Th=!Nh,bh=Th?Lh:Rh;"useSyncExternalStore"in Vl&&(e=>e.useSyncExternalStore)(Vl);const Ad=x.exports.createContext(null),eu=x.exports.createContext(null),ci=x.exports.createContext(null),nl=x.exports.createContext(null),zn=x.exports.createContext({outlet:null,matches:[]}),$d=x.exports.createContext(null);function Va(){return Va=Object.assign?Object.assign.bind():function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var r in n)Object.prototype.hasOwnProperty.call(n,r)&&(e[r]=n[r])}return e},Va.apply(this,arguments)}function _h(e,t){let{relative:n}=t===void 0?{}:t;dr()||ve(!1);let{basename:r,navigator:i}=x.exports.useContext(ci),{hash:o,pathname:l,search:s}=Id(e,{relative:n}),u=l;return r!=="/"&&(u=l==="/"?r:tn([r,l])),i.createHref({pathname:u,search:s,hash:o})}function dr(){return x.exports.useContext(nl)!=null}function rl(){return dr()||ve(!1),x.exports.useContext(nl).location}function di(){dr()||ve(!1);let{basename:e,navigator:t}=x.exports.useContext(ci),{matches:n}=x.exports.useContext(zn),{pathname:r}=rl(),i=JSON.stringify(Md(n).map(s=>s.pathnameBase)),o=x.exports.useRef(!1);return x.exports.useEffect(()=>{o.current=!0}),x.exports.useCallback(function(s,u){if(u===void 0&&(u={}),!o.current)return;if(typeof s=="number"){t.go(s);return}let c=Od(s,JSON.parse(i),r,u.relative==="path");e!=="/"&&(c.pathname=c.pathname==="/"?e:tn([e,c.pathname])),(u.replace?t.replace:t.push)(c,u.state,u)},[e,t,i,r])}function Mh(){let{matches:e}=x.exports.useContext(zn),t=e[e.length-1];return t?t.params:{}}function Id(e,t){let{relative:n}=t===void 0?{}:t,{matches:r}=x.exports.useContext(zn),{pathname:i}=rl(),o=JSON.stringify(Md(r).map(l=>l.pathnameBase));return x.exports.useMemo(()=>Od(e,JSON.parse(o),i,n==="path"),[e,o,i,n])}function Oh(e,t){dr()||ve(!1);let{navigator:n}=x.exports.useContext(ci),r=x.exports.useContext(eu),{matches:i}=x.exports.useContext(zn),o=i[i.length-1],l=o?o.params:{};o&&o.pathname;let s=o?o.pathnameBase:"/";o&&o.route;let u=rl(),c;if(t){var p;let w=typeof t=="string"?cr(t):t;s==="/"||((p=w.pathname)==null?void 0:p.startsWith(s))||ve(!1),c=w}else c=u;let g=c.pathname||"/",m=s==="/"?g:g.slice(s.length)||"/",C=qp(e,{pathname:m}),y=Fh(C&&C.map(w=>Object.assign({},w,{params:Object.assign({},l,w.params),pathname:tn([s,n.encodeLocation?n.encodeLocation(w.pathname).pathname:w.pathname]),pathnameBase:w.pathnameBase==="/"?s:tn([s,n.encodeLocation?n.encodeLocation(w.pathnameBase).pathname:w.pathnameBase])})),i,r||void 0);return t&&y?x.exports.createElement(nl.Provider,{value:{location:Va({pathname:"/",search:"",hash:"",state:null,key:"default"},c),navigationType:Wt.Pop}},y):y}function Ah(){let e=Hh(),t=wh(e)?e.status+" "+e.statusText:e instanceof Error?e.message:JSON.stringify(e),n=e instanceof Error?e.stack:null,i={padding:"0.5rem",backgroundColor:"rgba(200,200,200, 0.5)"},o=null;return x.exports.createElement(x.exports.Fragment,null,x.exports.createElement("h2",null,"Unexpected Application Error!"),x.exports.createElement("h3",{style:{fontStyle:"italic"}},t),n?x.exports.createElement("pre",{style:i},n):null,o)}class $h extends x.exports.Component{constructor(t){super(t),this.state={location:t.location,error:t.error}}static getDerivedStateFromError(t){return{error:t}}static getDerivedStateFromProps(t,n){return n.location!==t.location?{error:t.error,location:t.location}:{error:t.error||n.error,location:n.location}}componentDidCatch(t,n){console.error("React Router caught the following error during render",t,n)}render(){return this.state.error?x.exports.createElement(zn.Provider,{value:this.props.routeContext},x.exports.createElement($d.Provider,{value:this.state.error,children:this.props.component})):this.props.children}}function Ih(e){let{routeContext:t,match:n,children:r}=e,i=x.exports.useContext(Ad);return i&&i.static&&i.staticContext&&(n.route.errorElement||n.route.ErrorBoundary)&&(i.staticContext._deepestRenderedBoundaryId=n.route.id),x.exports.createElement(zn.Provider,{value:t},r)}function Fh(e,t,n){if(t===void 0&&(t=[]),e==null)if(n!=null&&n.errors)e=n.matches;else return null;let r=e,i=n==null?void 0:n.errors;if(i!=null){let o=r.findIndex(l=>l.route.id&&(i==null?void 0:i[l.route.id]));o>=0||ve(!1),r=r.slice(0,Math.min(r.length,o+1))}return r.reduceRight((o,l,s)=>{let u=l.route.id?i==null?void 0:i[l.route.id]:null,c=null;n&&(l.route.ErrorBoundary?c=x.exports.createElement(l.route.ErrorBoundary,null):l.route.errorElement?c=l.route.errorElement:c=x.exports.createElement(Ah,null));let p=t.concat(r.slice(0,s+1)),g=()=>{let m=o;return u?m=c:l.route.Component?m=x.exports.createElement(l.route.Component,null):l.route.element&&(m=l.route.element),x.exports.createElement(Ih,{match:l,routeContext:{outlet:o,matches:p},children:m})};return n&&(l.route.ErrorBoundary||l.route.errorElement||s===0)?x.exports.createElement($h,{location:n.location,component:c,error:u,children:g(),routeContext:{outlet:null,matches:p}}):g()},null)}var b1;(function(e){e.UseBlocker="useBlocker",e.UseRevalidator="useRevalidator"})(b1||(b1={}));var Po;(function(e){e.UseBlocker="useBlocker",e.UseLoaderData="useLoaderData",e.UseActionData="useActionData",e.UseRouteError="useRouteError",e.UseNavigation="useNavigation",e.UseRouteLoaderData="useRouteLoaderData",e.UseMatches="useMatches",e.UseRevalidator="useRevalidator"})(Po||(Po={}));function jh(e){let t=x.exports.useContext(eu);return t||ve(!1),t}function Dh(e){let t=x.exports.useContext(zn);return t||ve(!1),t}function Bh(e){let t=Dh(),n=t.matches[t.matches.length-1];return n.route.id||ve(!1),n.route.id}function Hh(){var e;let t=x.exports.useContext($d),n=jh(Po.UseRouteError),r=Bh(Po.UseRouteError);return t||((e=n.errors)==null?void 0:e[r])}function Uh(e){let{to:t,replace:n,state:r,relative:i}=e;dr()||ve(!1);let o=x.exports.useContext(eu),l=di();return x.exports.useEffect(()=>{o&&o.navigation.state!=="idle"||l(t,{replace:n,state:r,relative:i})}),null}function Re(e){ve(!1)}function Vh(e){let{basename:t="/",children:n=null,location:r,navigationType:i=Wt.Pop,navigator:o,static:l=!1}=e;dr()&&ve(!1);let s=t.replace(/^\/*/,"/"),u=x.exports.useMemo(()=>({basename:s,navigator:o,static:l}),[s,o,l]);typeof r=="string"&&(r=cr(r));let{pathname:c="/",search:p="",hash:g="",state:m=null,key:C="default"}=r,y=x.exports.useMemo(()=>{let w=qs(c,s);return w==null?null:{location:{pathname:w,search:p,hash:g,state:m,key:C},navigationType:i}},[s,c,p,g,m,C,i]);return y==null?null:x.exports.createElement(ci.Provider,{value:u},x.exports.createElement(nl.Provider,{children:n,value:y}))}function Wh(e){let{children:t,location:n}=e,r=x.exports.useContext(Ad),i=r&&!t?r.router.routes:Wa(t);return Oh(i,n)}var _1;(function(e){e[e.pending=0]="pending",e[e.success=1]="success",e[e.error=2]="error"})(_1||(_1={}));new Promise(()=>{});function Wa(e,t){t===void 0&&(t=[]);let n=[];return x.exports.Children.forEach(e,(r,i)=>{if(!x.exports.isValidElement(r))return;if(r.type===x.exports.Fragment){n.push.apply(n,Wa(r.props.children,t));return}r.type!==Re&&ve(!1),!r.props.index||!r.props.children||ve(!1);let o=[...t,i],l={id:r.props.id||o.join("-"),caseSensitive:r.props.caseSensitive,element:r.props.element,Component:r.props.Component,index:r.props.index,path:r.props.path,loader:r.props.loader,action:r.props.action,errorElement:r.props.errorElement,ErrorBoundary:r.props.ErrorBoundary,hasErrorBoundary:r.props.ErrorBoundary!=null||r.props.errorElement!=null,shouldRevalidate:r.props.shouldRevalidate,handle:r.props.handle,lazy:r.props.lazy};r.props.children&&(l.children=Wa(r.props.children,o)),n.push(l)}),n}/**
 * React Router DOM v6.9.0
 *
 * Copyright (c) Remix Software Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.md file in the root directory of this source tree.
 *
 * @license MIT
 */function Ga(){return Ga=Object.assign?Object.assign.bind():function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var r in n)Object.prototype.hasOwnProperty.call(n,r)&&(e[r]=n[r])}return e},Ga.apply(this,arguments)}function Gh(e,t){if(e==null)return{};var n={},r=Object.keys(e),i,o;for(o=0;o<r.length;o++)i=r[o],!(t.indexOf(i)>=0)&&(n[i]=e[i]);return n}function Qh(e){return!!(e.metaKey||e.altKey||e.ctrlKey||e.shiftKey)}function Yh(e,t){return e.button===0&&(!t||t==="_self")&&!Qh(e)}const Kh=["onClick","relative","reloadDocument","replace","state","target","to","preventScrollReset"];function Zh(e){let{basename:t,children:n,window:r}=e,i=x.exports.useRef();i.current==null&&(i.current=Zp({window:r,v5Compat:!0}));let o=i.current,[l,s]=x.exports.useState({action:o.action,location:o.location});return x.exports.useLayoutEffect(()=>o.listen(s),[o]),x.exports.createElement(Vh,{basename:t,children:n,location:l.location,navigationType:l.action,navigator:o})}const Xh=typeof window!="undefined"&&typeof window.document!="undefined"&&typeof window.document.createElement!="undefined",Jh=/^(?:[a-z][a-z0-9+.-]*:|\/\/)/i,bn=x.exports.forwardRef(function(t,n){let{onClick:r,relative:i,reloadDocument:o,replace:l,state:s,target:u,to:c,preventScrollReset:p}=t,g=Gh(t,Kh),{basename:m}=x.exports.useContext(ci),C,y=!1;if(typeof c=="string"&&Jh.test(c)&&(C=c,Xh)){let d=new URL(window.location.href),h=c.startsWith("//")?new URL(d.protocol+c):new URL(c),k=qs(h.pathname,m);h.origin===d.origin&&k!=null?c=k+h.search+h.hash:y=!0}let w=_h(c,{relative:i}),P=qh(c,{replace:l,state:s,target:u,preventScrollReset:p,relative:i});function f(d){r&&r(d),d.defaultPrevented||P(d)}return x.exports.createElement("a",Ga({},g,{href:C||w,onClick:y||o?r:f,ref:n,target:u}))});var M1;(function(e){e.UseScrollRestoration="useScrollRestoration",e.UseSubmitImpl="useSubmitImpl",e.UseFetcher="useFetcher"})(M1||(M1={}));var O1;(function(e){e.UseFetchers="useFetchers",e.UseScrollRestoration="useScrollRestoration"})(O1||(O1={}));function qh(e,t){let{target:n,replace:r,state:i,preventScrollReset:o,relative:l}=t===void 0?{}:t,s=di(),u=rl(),c=Id(e,{relative:l});return x.exports.useCallback(p=>{if(Yh(p,n)){p.preventDefault();let g=r!==void 0?r:Eo(u)===Eo(c);s(e,{replace:g,state:i,preventScrollReset:o,relative:l})}},[u,s,c,r,i,n,e,o,l])}const e4=E.div`
  position: absolute;
  width: 32.5rem;
  height: 4rem;
  top: 1.7rem;
  font-size: 0.7rem;

  background: rgba(0, 0, 0, 0.75);
  border-radius: 37px;

  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 2rem;

  .team {
    display: flex;
    gap: 0.5rem;

    span {
      margin-bottom: -1.4rem;
    }
    h1 {
      margin-top: -0.6rem;
    }

    &-timer {
      .time {
        display: flex;
        align-items: center;
        justify-content: center;

        background: rgba(0, 0, 0, 0.53);
        border-radius: 40px;
        width: 100%;
        height: 2rem;
        font-size: 0.6rem;
      }
    }
  }
`;function t4(){return v("svg",{xmlns:"http://www.w3.org/2000/svg",width:"30",height:"30",fill:"none",viewBox:"0 0 30 30",children:[a("path",{fill:"#f20a45",d:"M14.483 0h1.034c.286 0 .518.232.518.517v4.655a.517.517 0 01-.518.518h-1.034a.517.517 0 01-.518-.518V.518c0-.285.232-.517.518-.517zM14.483 24.31h1.034c.286 0 .518.232.518.518v4.655a.517.517 0 01-.518.517h-1.034a.517.517 0 01-.518-.517v-4.655c0-.286.232-.518.518-.518zM24.828 13.966h4.655c.285 0 .517.231.517.517v1.034a.517.517 0 01-.517.518h-4.655a.517.517 0 01-.518-.518v-1.034c0-.286.232-.518.518-.518zM.517 13.966h4.655c.286 0 .518.231.518.517v1.034a.517.517 0 01-.518.518H.518A.517.517 0 010 15.517v-1.034c0-.286.232-.518.517-.518zM28.283 12.931A13.401 13.401 0 0017.069 1.76v2.084a11.36 11.36 0 019.119 9.088h2.095zM1.764 12.931h2.09a11.366 11.366 0 019.077-9.078v-2.09A13.397 13.397 0 001.764 12.932zM28.283 17.069h-2.095a11.36 11.36 0 01-9.12 9.088v2.084A13.401 13.401 0 0028.284 17.07zM12.931 28.236v-2.09a11.366 11.366 0 01-9.078-9.077h-2.09a13.397 13.397 0 0011.168 11.167zM17.855 11.922l-1.117.745a1.534 1.534 0 01-.859.264h-1.758a1.555 1.555 0 01-.87-.269l-1.106-.74c-.896.097-1.78.275-2.643.533l-.187.062a.333.333 0 01-.067.02c.155 1.6.698 2.846 1.614 3.498a2.01 2.01 0 002.586 0c.693-.694 1.086-1.04 1.552-1.04.466 0 .858.347 1.552 1.04a2.01 2.01 0 002.586 0c.92-.652 1.459-1.889 1.614-3.497-.016-.005-.037-.01-.052-.016a1.743 1.743 0 00-.15-.051 14.324 14.324 0 00-2.695-.549z"}),a("path",{fill:"#f20a45",d:"M19.138 19.138a3.615 3.615 0 001.034-2.07l.037-.584a4.18 4.18 0 01-.471.393 3.44 3.44 0 01-1.981.657 2.685 2.685 0 01-1.935-.77A5.985 5.985 0 0015 16.04a5.99 5.99 0 00-.822.724 2.685 2.685 0 01-1.935.77 3.44 3.44 0 01-1.98-.656 4.177 4.177 0 01-.472-.393l.037.584c.102.94.46 1.835 1.034 2.586l1.552 1.552c.42.384.984.572 1.552.517h2.069a1.374 1.374 0 001.034-.517l2.069-2.07zm-5.322.884c-.204.2-.531.2-.735 0l-1.034-1.034a.52.52 0 01.734-.735l1.035 1.035a.522.522 0 010 .734zm2.219.15a.531.531 0 01-.368-.15.522.522 0 010-.734l1.035-1.035a.52.52 0 11.734.735l-1.034 1.034a.53.53 0 01-.367.15zM21.047 11.545a.512.512 0 00.553-.823l-1.82-1.81a.548.548 0 00-.296-.145l-3.413-.486a.349.349 0 00-.073-.005h-1.996c-.025-.001-.049 0-.073.005l-3.414.486a.522.522 0 00-.294.15l-1.816 1.805a.517.517 0 00.559.823c.072-.026.145-.047.222-.072a15.08 15.08 0 013.047-.595.53.53 0 01.33.082l1.273.849a.512.512 0 00.285.088h1.758c.102 0 .2-.031.285-.088l1.272-.849a.53.53 0 01.331-.082 14.767 14.767 0 013.28.667z"})]})}function n4(){return a("svg",{xmlns:"http://www.w3.org/2000/svg",width:"23",height:"23",fill:"none",viewBox:"0 0 23 23",children:a("path",{fill:"#f20a45",d:"M17.122 22.196c-.297 0-.59-.072-.851-.21l-4.87-2.56a.26.26 0 00-.245 0l-4.869 2.56a1.827 1.827 0 01-2.65-1.927l.929-5.42a.263.263 0 00-.078-.235L.552 10.563a1.826 1.826 0 011.016-3.117l5.44-.79a.263.263 0 00.198-.144l2.432-4.934a1.826 1.826 0 013.276 0l2.433 4.932a.266.266 0 00.199.145l5.444.79a1.827 1.827 0 011.016 3.117l-3.94 3.839a.265.265 0 00-.078.234l.93 5.421a1.83 1.83 0 01-1.797 2.137v.003zm-5.844-4.364c.297 0 .589.072.85.211l4.87 2.559a.251.251 0 00.277-.02.255.255 0 00.106-.259l-.93-5.421a1.83 1.83 0 01.524-1.617l3.94-3.84a.264.264 0 00-.147-.45l-5.443-.791a1.824 1.824 0 01-1.375-1l-2.437-4.932a.265.265 0 00-.474 0L8.607 7.203a1.824 1.824 0 01-1.375 1l-5.443.792a.263.263 0 00-.146.45l3.939 3.84a1.83 1.83 0 01.525 1.617l-.93 5.421a.264.264 0 00.384.279l4.867-2.56c.263-.138.554-.21.85-.21z"})})}function r4(){var m,C,y,w;const[e,t]=x.exports.useState(10),[n,r]=x.exports.useState(),[i,o]=x.exports.useState("-86904375"),[l,s]=x.exports.useState({headshots:0,points:0,time:"1:00"}),[u,c]=x.exports.useState(!1),[p,g]=x.exports.useState({});return we("aimLabsKillFeed",P=>{r(P.killfeed),o(P.image)}),we("aimLabsScore",P=>{c(P.initRound),g(P.buttons),s(P.score),console.log(P.buttons)}),x.exports.useEffect(()=>{e<=0&&c(!1)},[e]),v(df,{children:[n&&a(al,{killfeed:n,image:i}),v(e4,{children:[v("div",{className:"team",children:[a(t4,{}),v("div",{children:[a("span",{children:"HEADSHOTS"}),a("h1",{children:l.headshots})]})]}),v("div",{className:"team-timer",children:[a("span",{children:"TEMPO RESTANTE"}),a("div",{className:"time",children:a("h1",{children:l.time})})]}),v("div",{className:"team",children:[a(n4,{}),v("div",{children:[a("span",{children:"PONTUA\xC7\xC3O"}),a("h1",{children:l.points})]})]})]}),u?a(cf,{time:e,title:"AIMLABS",setTime:t}):null,p!=null&&p.enter?a(ii,{shortcut:(m=p==null?void 0:p.enter)==null?void 0:m.control,text:(C=p==null?void 0:p.enter)==null?void 0:C.text,altura:75}):null,p!=null&&p.exit?a(ii,{shortcut:(y=p==null?void 0:p.exit)==null?void 0:y.control,text:(w=p==null?void 0:p.exit)==null?void 0:w.text,altura:81}):null]})}const Fd=x.exports.createContext(null);function i4({children:e}){const t=di(),[n,r]=x.exports.useState({discord:"discord.gg/santagrupo",logo:"https://media.discordapp.net/attachments/978975375914831912/1059710189416230982/maresia.png"}),[i,o]=x.exports.useState(0);return we("router",l=>{t(l.path.replaceAll("/","/"))}),we("back",()=>{t(-1)}),x.exports.useEffect(()=>{We("GetServerInfos").then(l=>{r(l)})},[]),we("UpdateHealth",l=>{o(l-100)}),a(Fd.Provider,{value:{serverInfos:n,health:i},children:e})}const jd=()=>x.exports.useContext(Fd),o4=E.div`
  position: absolute;
  top: 6.8%;
  right: 10%;
  font-size: 1vw;
  padding: .2vw 1vw;
  border-radius: 1vw;
  display: flex;
  gap: 1.4vw;
  align-items: center;
  justify-content: space-between;
  background-color: rgba(0, 0, 0, .5);
`;var Dd={color:void 0,size:void 0,className:void 0,style:void 0,attr:void 0},A1=Y.createContext&&Y.createContext(Dd),nn=globalThis&&globalThis.__assign||function(){return nn=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++){t=arguments[n];for(var i in t)Object.prototype.hasOwnProperty.call(t,i)&&(e[i]=t[i])}return e},nn.apply(this,arguments)},l4=globalThis&&globalThis.__rest||function(e,t){var n={};for(var r in e)Object.prototype.hasOwnProperty.call(e,r)&&t.indexOf(r)<0&&(n[r]=e[r]);if(e!=null&&typeof Object.getOwnPropertySymbols=="function")for(var i=0,r=Object.getOwnPropertySymbols(e);i<r.length;i++)t.indexOf(r[i])<0&&Object.prototype.propertyIsEnumerable.call(e,r[i])&&(n[r[i]]=e[r[i]]);return n};function Bd(e){return e&&e.map(function(t,n){return Y.createElement(t.tag,nn({key:n},t.attr),Bd(t.child))})}function Ie(e){return function(t){return Y.createElement(a4,nn({attr:nn({},e.attr)},t),Bd(e.child))}}function a4(e){var t=function(n){var r=e.attr,i=e.size,o=e.title,l=l4(e,["attr","size","title"]),s=i||n.size||"1em",u;return n.className&&(u=n.className),e.className&&(u=(u?u+" ":"")+e.className),Y.createElement("svg",nn({stroke:"currentColor",fill:"currentColor",strokeWidth:"0"},n.attr,r,l,{className:u,style:nn(nn({color:e.color||n.color},n.style),e.style),height:s,width:s,xmlns:"http://www.w3.org/2000/svg"}),o&&Y.createElement("title",null,o),e.children)};return A1!==void 0?Y.createElement(A1.Consumer,null,function(n){return t(n)}):t(Dd)}function s4(e){return Ie({tag:"svg",attr:{viewBox:"0 0 512 512"},child:[{tag:"path",attr:{d:"M262.81 16.098c-10.335-.044-20.657.6-30.867 1.894l-2.68.246c1.754 19.05-1.177 32.7-7.144 39.69-5.967 6.99-15.964 10.454-36.102 6.328l-18.686-3.83 8.426 17.11c5.744 11.666 2.894 24.13-5.42 31.386s-22.805 10.594-44.797-1.443l-17.257-9.447 3.582 19.344c3.326 17.958-1.815 26.41-10.158 31.99-8.343 5.582-21.628 7.223-33.15 4.725l-.14.644-2.292-1.51c-8.416 30.07-10.557 65.306-4.252 106.08l15.184 94.135 70.295-13.24 3.46 18.366-15.384 2.897L179.96 488.79h25.39l-7.81-61.89 18.534-2.337 8.104 64.226h29.613v-65.325h18.69v65.324h29.61l8.105-64.228 18.534 2.338-7.81 61.89h25.486l44.352-126.808-18.133-3.416 3.46-18.365 70.185 13.22 18.236-94.22c12.634-81.883-9.59-141.71-48.71-181.966-39.135-40.268-95.95-60.884-152.966-61.136h-.02zm-14.51 20.14c45.57 29.486 39.706 97.78-19.587 70.834 34.772 67.943-24.572 97.148-69.838 55.2 3.894 37.6-40.093 48.023-69.316 11.056 7.962-1.166 15.703-3.855 22.538-8.428 10.563-7.066 17.958-19.23 19.1-34.785 20.852 6.868 39.385 3.4 51.43-7.113 10.958-9.566 16.144-24.103 14.368-38.635 16.913.726 30.568-4.03 39.34-14.306 7.624-8.933 11.127-20.532 11.965-33.822zm-61.9 167.98c32.884 0 59.54 26.656 59.54 59.54 0 32.885-26.656 59.543-59.54 59.543-32.883 0-59.543-26.657-59.543-59.542 0-32.886 26.66-59.54 59.543-59.54zm157.543 0c32.884 0 59.54 26.656 59.54 59.54 0 32.885-26.656 59.543-59.54 59.543-32.883 0-59.543-26.657-59.543-59.542 0-32.886 26.66-59.54 59.543-59.54zm-80.675 79.74l39.937 101.6-17.03 7.05-22.905-35.477-22.905 35.477-17.62-7.048 40.523-101.603z"}}]})(e)}function u4(e){return Ie({tag:"svg",attr:{viewBox:"0 0 512 512"},child:[{tag:"path",attr:{d:"M172.7 19.27l-25.4 25.46L256 153.5 364.7 44.73l-25.4-25.46L256 102.5l-83.3-83.23zM44.73 147.3l-25.46 25.4L102.5 256l-83.23 83.3 25.46 25.4L153.5 256 44.73 147.3zm422.47 0L358.6 256l108.6 108.7 25.4-25.4-83.2-83.3 83.2-83.3-25.4-25.4zM256 358.5L147.3 467.3l25.4 25.4 83.3-83.2 83.3 83.2 25.4-25.4L256 358.5z"}}]})(e)}function c4({kills:e}){return v(o4,{children:[a(s4,{}),a("span",{children:e})]})}function d4(){const{serverInfos:e,health:t}=jd(),[n,r]=Y.useState(),[i,o]=Y.useState("https://media.discordapp.net/attachments/1008423378065043566/1037847123804295168/-86904375.png"),[l,s]=Y.useState("Entrar"),[u,c]=Y.useState("Sair"),[p,g]=Y.useState("E"),[m,C]=Y.useState("F"),[y,w]=Y.useState(0);return we("killFeed",P=>{r(P.killFeed),o(P.image)}),we("killCount",P=>{w(P)}),we("setText",P=>{C(P.enter),g(P.exit)}),v(df,{children:[a(al,{killfeed:n,image:i}),a(c4,{kills:y}),p!=""&&a(ii,{shortcut:p,text:u,altura:75}),m!=""&&a(ii,{shortcut:m,text:l,altura:81}),a(ff,{discord:e.discord,health:t})]})}const f4=E.div`
  background-size: 100% 100%;
  height: 100vh;
  width: 100vw;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: 'Poppins', sans-serif;
  overflow: hidden;
  position: relative;
`,p4=E.div`
  height: 34vh;
  position: absolute;
  left: 0%;
  right: 0%;
  top: 0%;
  bottom: 0%;

  font-family: Poppins;
  font-style: normal;
  font-weight: 400;
  font-size: 2.4rem;

  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;

  background: linear-gradient(180deg, #000000 0%, rgba(0, 0, 0, 0) 100%);

  mix-blend-mode: normal;

  .Text-Left {
    text-align: left;
    font-size: 1.45rem;
  }

  strong {
    font-weight: 700;
  }
`,h4=E.div`
  width: max-content;
  height: max-content;
  display: flex;
  flex-direction: column;
`;function m4({time:e,text:t}){return a(p4,{children:v(h4,{children:[a("span",{className:"Text-Left",children:"DOMINA\xC7\xC3O"}),v("span",{children:[t," ",a("strong",{children:e})]})]})})}const g4=E.div`
  width: 16.5rem;
  min-height: 19rem;

  font-size: .8rem;
  padding: 2rem;

  border: 0.1vh solid #F20A45;

  background: rgba(0, 0, 0, 0.22);
  border-radius: 4px;

  .Box-Title {
    font-size: 1.8rem;
    font-family: 'Poppins';
    font-style: normal;
    font-weight: 700;
    line-height: 35px;
  }

  .Box-Content {
    margin-top: 1rem;
    display: flex;
    flex-direction: column;
    font-family: 'Poppins';
    font-style: normal;
    font-weight: 500;
    line-height: 35px;
    font-size: 1rem;

    &-Text {
      margin-bottom: 0;
    }
    &-Value {
      margin-top: -.7rem;
      font-family: 'Poppins';
      font-style: normal;
      font-weight: 700;
      font-size: 1.2rem;
      line-height: 30px;
    }
  }
`;function v4({group:e,points:t,players:n}){return v(g4,{children:[a("div",{className:"Box-Title",children:"DOMINA\xC7\xC3O"}),v("div",{className:"Box-Content",children:[a("span",{className:"Box-Content-Text",children:"MINHA ORGANIZA\xC7\xC3O"}),a("span",{className:"Box-Content-Value",children:e})]}),v("div",{className:"Box-Content",children:[a("span",{className:"Box-Content-Text",children:"PONTUA\xC7\xC3O"}),a("span",{className:"Box-Content-Value",children:t})]}),v("div",{className:"Box-Content",children:[a("span",{className:"Box-Content-Text",children:"PLAYERS VIVOS"}),a("span",{className:"Box-Content-Value",children:n})]})]})}const y4=E.div`
  position: absolute;
  top: 50%;
  left: 2vw;
  transform: translateY(-50%);

  display: flex;
  justify-content: flex-start;
  align-items: flex-start;
  flex-direction: column;
`;function w4({teamScore:e,isHidden:t}){return a(y4,{children:!t&&a(v4,{...e})})}const x4=E.div`
  position: absolute;
  top: 2vh;
  left: 50%;
  transform: translateX(-50%);

  img {
    height: 10vh;
  }
`;function C4({link:e}){return a(x4,{children:a("img",{src:e})})}function k4(){const{serverInfos:e,health:t}=jd(),[n,r]=x.exports.useState(0),[i,o]=x.exports.useState(),[l,s]=x.exports.useState("https://media.discordapp.net/attachments/1008423378065043566/1037847123804295168/-86904375.png"),[u,c]=x.exports.useState({group:"YAKUZA",players:10,points:1e3}),[p,g]=x.exports.useState([{name:"VERMELHOS",score:1e3},{name:"VERDES",score:999},{name:"AMARELOS",score:988},{name:"ROXOS",score:115},{name:"YAKUZA",score:19}]),[m,C]=x.exports.useState(!1);return we("HideUI",y=>{C(y)}),we("KillFeed",y=>{o(y.killFeed),s(y.image)}),we("UpdateTeamsScore",y=>{g(y)}),we("UpdateSelfTeamScore",y=>{c(y)}),we("UpdateCountdown",y=>{r(y)}),v(f4,{children:[a(al,{killfeed:i,image:l}),n>0?a(m4,{time:`${n}S`,text:"INICIANDO EM"}):v(tl,{children:[a(C4,{link:e.logo}),u&&a(w4,{teamScore:u,isHidden:m}),!m&&a(pf,{teams:p}),a(ff,{discord:e.discord,health:t})]})]})}const S4=E.div`
    background-size: 100% 100%;
    height: 100vh;
    width: 100vw;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Poppins', sans-serif;
    overflow: hidden;
    position: relative;

    .Status {
        position: absolute;
        right: 0;
        top: 72%;
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }

    .Mode {
        display: flex;
        flex-direction: column;
        gap: 1rem;
        position: absolute;
        left: 1rem;
        top: 66%;
        font-size: .8rem;

        &-item {
            display: flex;
            gap: 1rem;

            span {
                font-weight: 275;
            }
            h1 {
                margin-top: -.5rem;
            }
        }
    }
`,E4=E.div`
    position: absolute;
    top: 0;

    .scoreboard {
        display: flex;
        gap: 1.2rem;

        &-user {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1rem;
            width: 6rem;

            &-avatar {
                width: 6.2rem;
                border-radius: 0 0 16px 16px;
            }

            &-gun {

                img {
                    max-width: 7rem;
                }
            }
        }
    }
`,P4=E.div`

    .challenger {
        position: absolute;
        top: 50%;
        right: 0;

        &-guns {
            display: flex;
            flex-direction: column;
            align-items: end;
            gap: 2rem;
            &-item {
                img {
                    max-width: 10.5rem;
                }
            }
            &-active {
                display: flex;
                flex-direction: column;
                align-items: end;
                gap: 1.6rem;

                span {
                    margin-right: 1.2rem;
                    margin-bottom: -0.8rem;
                }

                img {
                    max-width: 14.5rem;
                }
            }

            &-points {
                display: flex;
                gap: 1rem;
                font-size: .6rem;

                &-item {
                    display: flex;

                    gap: .4rem;
                }
            }
        }
    }
`;function $1(){return v("svg",{xmlns:"http://www.w3.org/2000/svg",width:"211",height:"4",fill:"none",viewBox:"0 0 211 4",children:[a("path",{stroke:"url(#paint0_linear_8_453)",strokeWidth:"3",d:"M214.5 2.5L0 2.498"}),a("defs",{children:v("linearGradient",{id:"paint0_linear_8_453",x1:"160",x2:"0",y1:"1.015",y2:"-2.985",gradientUnits:"userSpaceOnUse",children:[a("stop",{stopColor:"#fff"}),a("stop",{offset:"1",stopColor:"#fff",stopOpacity:"0"})]})})]})}function z4(){const[e,t]=Y.useState(10),[n,r]=Y.useState("Sair"),[i,o]=Y.useState([]),[l,s]=Y.useState({activeGun:-86904375,guns:[{gunHash:-86904375},{gunHash:-86904375}]}),[u,c]=Y.useState(!0),[p,g]=Y.useState(),[m,C]=Y.useState("https://media.discordapp.net/attachments/1008423378065043566/1037847123804295168/-86904375.png");we("gunGame",w=>{o(w.users),c(w.initRound)}),we("killFeedGunGame",w=>{g(w.killFeed),C(w.image)}),we("gunGameChallenges",w=>{s(w.challenges)}),Y.useEffect(()=>{e<=0&&c(!1)},[e]);const y=l.guns.slice(0,2).map((w,P)=>a("div",{className:"challenger-guns-item",children:a("img",{src:`nui://arena/web-side/assets/weapons/${w.gunHash}.png`,alt:""})}));return v(S4,{children:[a(al,{killfeed:p,image:m}),a(Kp,{}),l.guns.length>0?a(P4,{children:a("div",{className:"challenger",children:v("div",{className:"challenger-guns",children:[y,v("div",{className:"challenger-guns-active",children:[a("span",{children:"Proxima arma"}),a($1,{}),a("div",{className:"challenger-guns-active-img",children:a("img",{src:`nui://arena/web-side/assets/weapons/${l.activeGun}.png`,alt:""})}),a($1,{})]})]})})}):null,i.length>0?a(E4,{children:a("div",{className:"scoreboard",children:i.map((w,P)=>v("div",{className:"scoreboard-user",children:[a("img",{className:"scoreboard-user-avatar",src:`https://ui-avatars.com/api/?name=${w.name}&background=00000&color=fff`,alt:""}),a("div",{className:"scoreboard-user-gun",children:a("img",{src:`nui://arena/web/build/assets/weapons/${w.gun}.png`,alt:""})})]},P))})}):null,u?a(cf,{time:e,title:"GUNGAME",setTime:t}):null,a(ii,{shortcut:"G",text:n,altura:81})]})}const un=E.div`
  border: 0.01vh solid #F20A45;
  background: rgba(0, 0, 0, 0.5);
  border-radius: 1.5vh;
  padding: 1vh 1vw;
  overflow: hidden;
`,fi=E.button`
  display: flex;
  align-items: center;
  border-radius: 0.9vh;
  background-color: rgba(255, 255, 255, 0.04);

  padding: 0.9vh;
  text-transform: uppercase;
  font-weight: 600;

  outline: none;
  border: none;

  transition: background-color 0.2s;

  &:hover {
    background-color: rgba(255, 255, 255, 0.08);
  }
`,tu=E.div`
  height: 100%;
  min-height: 4.25vh;
  padding: 0 1.25vw;
  border-left: 0.1vh solid #F20A45;
  text-transform: uppercase;
  border-radius: 1vh;
  background-color: rgba(255, 255, 255, 0.03);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.9vh;
  font-family: 'Rajdhani';
  font-weight: 600;

  svg {
    fill: #F20A45;
  }
`,R4=E(un)`
  display: flex;
  align-items: center;
  justify-content: space-between;
  grid-area: 1 / 2 / 2 / 3;
  padding: 1.5vh 1vw;
  overflow: visible;
`,L4=E.div`
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: flex-end;
`;function fr({children:e,text:t}){return v(R4,{children:[a(tu,{children:t}),a(L4,{children:e})]})}function N4(){return a("svg",{width:"20",height:"19",viewBox:"0 0 20 19",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:a("path",{d:"M19.5625 3.03124V7.34374C19.5625 7.53436 19.4868 7.71718 19.352 7.85197C19.2172 7.98676 19.0344 8.06249 18.8437 8.06249H14.5312C14.389 8.0626 14.2499 8.0205 14.1316 7.94153C14.0133 7.86256 13.9211 7.75027 13.8667 7.61887C13.8122 7.48746 13.798 7.34286 13.8258 7.20336C13.8535 7.06386 13.9221 6.93574 14.0227 6.83522L15.5501 5.30788L14.6022 4.44088L14.5798 4.41932C13.5808 3.4207 12.3096 2.73857 10.9252 2.45816C9.54081 2.17775 8.10445 2.31148 6.79559 2.84265C5.48674 3.37382 4.36341 4.27888 3.56593 5.44476C2.76846 6.61065 2.3322 7.98567 2.31165 9.39805C2.2911 10.8104 2.68717 12.1976 3.45039 13.3862C4.2136 14.5747 5.31013 15.5121 6.60298 16.0811C7.89583 16.6501 9.32769 16.8256 10.7197 16.5856C12.1117 16.3456 13.4021 15.7007 14.4297 14.7316C14.4983 14.6667 14.579 14.616 14.6673 14.5823C14.7555 14.5486 14.8495 14.5326 14.9439 14.5352C15.0383 14.5378 15.1312 14.559 15.2174 14.5976C15.3036 14.6361 15.3814 14.6913 15.4463 14.7599C15.5112 14.8285 15.5619 14.9092 15.5956 14.9974C15.6293 15.0856 15.6453 15.1796 15.6427 15.274C15.6401 15.3684 15.6189 15.4614 15.5803 15.5476C15.5418 15.6338 15.4866 15.7116 15.418 15.7765C13.8198 17.2898 11.701 18.1307 9.49999 18.125H9.38139C7.96881 18.1056 6.58261 17.7396 5.34462 17.0591C4.10663 16.3785 3.05476 15.4043 2.28145 14.222C1.50815 13.0398 1.03708 11.6857 0.909667 10.2787C0.78225 8.87176 1.00238 7.45504 1.55071 6.15309C2.09904 4.85113 2.95878 3.7038 4.05437 2.81192C5.14996 1.92005 6.44785 1.31094 7.83397 1.03814C9.22009 0.765332 10.652 0.837183 12.0039 1.24738C13.3557 1.65757 14.5861 2.39354 15.5869 3.39061L16.5689 4.28905L18.3352 2.51913C18.436 2.41827 18.5644 2.34965 18.7042 2.32198C18.8441 2.29432 18.989 2.30885 19.1205 2.36375C19.2521 2.41864 19.3643 2.51141 19.443 2.63027C19.5217 2.74912 19.5633 2.88869 19.5625 3.03124Z",fill:"white","fill-opacity":"0.5"})})}const T4=E(fi)`
  justify-content: center;
  height: 100%;
  width: 3.8vh;

  svg {
    height: 1.8vh;
    width: 1.8vh;
  }
`;function il({...e}){return a(T4,{...e,children:a(N4,{})})}function b4(){return a("svg",{width:"13",height:"13",viewBox:"0 0 13 13",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:a("path",{d:"M8.87221 8.88191L12.125 12.125M10.25 5.5625C10.25 8.15133 8.15133 10.25 5.5625 10.25C2.97367 10.25 0.875 8.15133 0.875 5.5625C0.875 2.97367 2.97367 0.875 5.5625 0.875C8.15133 0.875 10.25 2.97367 10.25 5.5625Z",stroke:"white","stroke-width":"1.1","stroke-linecap":"round","stroke-linejoin":"round"})})}const _4=E.div`
  height: 100%;
  min-width: 20vw;
  display: flex;
  align-items: center;
  border-radius: 0.9vh;
  background-color: rgba(255, 255, 255, 0.04);

  padding: 0.5vw 1.1vh;
  text-transform: uppercase;
  font-weight: 600;

  input {
    width: 100%;
    margin-left: 0.75vw;
    background: none;
    border: none;
    outline: none;
    color: rgba(255, 255, 255, 0.3);
    font-size: 0.775vw;
  }

  svg {
    height: 1.25vh;
    width: 1.25vw;
  }
`;function ol({icon:e,handleChange:t,...n}){return v(_4,{children:[e||a(b4,{}),a("input",{onChange:t,...n})]})}const Hd=E.div`
  position: absolute;
  width: 100%;
  background: rgba(43, 37, 29, 0.98);
  border-radius: 1vh;
  z-index: 9;
`,Ud=E.div`
  display: flex;
  align-items: center;
  justify-content: center;

  border-radius: 100vw;
  height: 1vw;
  width: 1vw;
  margin-right: 0.4vw;

  svg {
    width: 1vw;
    height: 0.8vh;
  }
`;function M4(){return a(Ud,{style:{background:"#F20A45"},children:a("svg",{width:"10",height:"7",viewBox:"0 0 10 7",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:a("path",{d:"M1 3.80001L3.32929 6.1293C3.36834 6.16835 3.43166 6.16835 3.47071 6.1293L9 0.600006",stroke:"white","stroke-linecap":"round"})})})}function O4(){return a(Ud,{style:{border:"0.15vw solid rgba(255, 255, 255, 0.3)"}})}function A4({isSelected:e,text:t,...n}){return v(nu,{...n,children:[e?a(M4,{}):a(O4,{})," ",t]})}function $4({isSelected:e,text:t,...n}){return a(nu,{className:e?"selected":"",...n,children:t})}function I4({type:e,...t}){switch(e){case"multi":return a(A4,{...t});case"single":return a($4,{...t})}}function F4({text:e,children:t,preMounter:n,...r}){return v(Gd,{children:[v(Wd,{style:{borderBottomRightRadius:r.isOpen?0:"1vh"},...r,children:[n||v("div",{className:"mounter",children:[v("b",{children:[a(h3,{}),a("span",{children:"Filtro:"})]}),a("span",{className:"text",children:e})]}),a("div",{className:"expandable",children:r.isOpen?a("div",{style:{transform:"rotate(180deg)"},children:a(I1,{})}):a(I1,{})})]}),t]})}function Vd({options:e,type:t,text:n,isOpen:r,preMounter:i,onClickOption:o,...l}){return a(F4,{text:n,isOpen:r,preMounter:i,...l,children:a(Hd,{children:r&&a("div",{style:{marginTop:"4.1vh",padding:"1vh 0.8vw 2vh 0.8vw"},children:e.map((s,u)=>a(I4,{type:t,onClick:()=>o&&o(u),...s},u))})})})}const Wd=E(fi)`
  display: flex;
  align-items: center;
  justify-content: space-between;	
  z-index: 10;
  text-transform: none;
  color: white;
  padding: 0.525vw 1.1vh;
  font-size: 0.7vw;
  border-left: 0vh solid #F20A45;
  transition: all 0.2s;

  svg {
    height: 1.3vh;
    width: 1.3vh;
  }
  
  .mounter {
    display: flex;
    .text {
      margin-left: 0.25vw;
      margin-right: 0.5vw;
      font-weight: 400;
    }
  }

  b {
    font-weight: bold;
    display: flex;
    align-items: center;

    span {
      margin-left: 0.35vw;
    }
  }

  .expandable {
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-weight: 400;

    svg {
      width: 0.5vw;
      height: 0.5vw;
    }
  }
`,Gd=E.div`
  position: relative;
  display: flex;
  flex-direction: column;
`,nu=E(fi)`
  width: 100%;
  margin-top: 0.5vh;
  padding: 0.5vh 0.6vw;
  color: white;
  font-weight: normal;
  font-size: 0.75vw;
  text-transform: none;
  border-radius: 0.5vh;
  transition: all 0.3s;
  border: 0.1vh solid transparent;

  &.selected {
    background: rgba(233, 174, 9, 0.2);
    border: 0.1vh solid #F20A45;
  }
`,j4=E.div`
  grid-area: 2 / 1 / 3 / 2;

  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  height: min-content;

  padding: 0.4vw;
  border-radius: 1.5vh;

  border-right: 0.05vh solid #F20A45;

  background-color: rgba(0, 0, 0, 0.5);

  .explore {
    display: flex;
    justify-content: center;
    align-items: center;

    border-radius: 1vh;
    height: 2.5vw;
    width: 100%;

    background-color: rgba(255, 255, 255, 0.02);
    color: #fff;

    &:not(:first-child) {
      margin-top: 0.5vh;
    }

    &.selected {
      background-color: #F20A45;
    }

    &:hover:not(.selected) {
      background-color: rgba(255, 255, 255, 0.04);
    }

    svg {
      height: 1.5vh;
      width: 1.5vw;
    }
  }
`;function D4(){return a("svg",{width:"22",height:"17",viewBox:"0 0 22 17",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:a("path",{d:"M21.9508 12.919C21.9512 12.9145 21.9512 12.91 21.9508 12.9055L20.448 4.77545C20.448 4.76966 20.448 4.76386 20.448 4.75807C20.216 3.42323 19.5473 2.21625 18.5582 1.34697C17.569 0.477688 16.3219 0.00107711 15.0338 4.27562e-07H6.95511C5.66335 -0.000522583 4.41278 0.478795 3.42334 1.35365C2.4339 2.22851 1.76896 3.44288 1.54547 4.78318L0.0500302 12.9055C0.0495886 12.91 0.0495886 12.9145 0.0500302 12.919C-0.0716933 13.6472 0.0300496 14.3972 0.340487 15.0603C0.650925 15.7233 1.1539 16.2649 1.77638 16.6064C2.39886 16.9478 3.10844 17.0714 3.80211 16.9591C4.49578 16.8468 5.13742 16.5045 5.63387 15.9819L5.66596 15.9462L9.30509 11.5909H12.6976L16.3385 15.9462C16.3486 15.9587 16.3596 15.9703 16.3706 15.9819C16.9893 16.6323 17.8273 16.9983 18.7013 17C19.1831 16.9997 19.659 16.8882 20.0956 16.6735C20.5322 16.4588 20.9188 16.146 21.2284 15.7571C21.538 15.3681 21.763 14.9125 21.8876 14.4223C22.0123 13.932 22.0335 13.4189 21.9499 12.919H21.9508ZM8.79897 6.95455H8.06546V7.72727C8.06546 7.93221 7.98818 8.12876 7.85062 8.27367C7.71306 8.41859 7.52648 8.5 7.33195 8.5C7.13741 8.5 6.95084 8.41859 6.81328 8.27367C6.67572 8.12876 6.59844 7.93221 6.59844 7.72727V6.95455H5.86493C5.67039 6.95455 5.48382 6.87313 5.34626 6.72822C5.2087 6.5833 5.13142 6.38676 5.13142 6.18182C5.13142 5.97688 5.2087 5.78033 5.34626 5.63542C5.48382 5.4905 5.67039 5.40909 5.86493 5.40909H6.59844V4.63636C6.59844 4.43142 6.67572 4.23488 6.81328 4.08996C6.95084 3.94505 7.13741 3.86364 7.33195 3.86364C7.52648 3.86364 7.71306 3.94505 7.85062 4.08996C7.98818 4.23488 8.06546 4.43142 8.06546 4.63636V5.40909H8.79897C8.9935 5.40909 9.18007 5.4905 9.31763 5.63542C9.45519 5.78033 9.53247 5.97688 9.53247 6.18182C9.53247 6.38676 9.45519 6.5833 9.31763 6.72822C9.18007 6.87313 8.9935 6.95455 8.79897 6.95455ZM12.4665 6.18182C12.4665 5.97688 12.5438 5.78033 12.6814 5.63542C12.8189 5.4905 13.0055 5.40909 13.2 5.40909H15.4006C15.5951 5.40909 15.7817 5.4905 15.9192 5.63542C16.0568 5.78033 16.1341 5.97688 16.1341 6.18182C16.1341 6.38676 16.0568 6.5833 15.9192 6.72822C15.7817 6.87313 15.5951 6.95455 15.4006 6.95455H13.2C13.0055 6.95455 12.8189 6.87313 12.6814 6.72822C12.5438 6.5833 12.4665 6.38676 12.4665 6.18182ZM20.2023 14.6306C20.0649 14.839 19.8896 15.0166 19.6866 15.1531C19.4835 15.2895 19.2568 15.3821 19.0195 15.4256C18.7325 15.4785 18.4376 15.4588 18.1591 15.3683C17.8807 15.2778 17.6266 15.119 17.4177 14.9049L14.6487 11.5909H15.0338C15.9703 11.591 16.8913 11.3393 17.7096 10.8596C18.5279 10.3799 19.2164 9.68809 19.7099 8.84966L20.5113 13.1962C20.5521 13.445 20.5458 13.6998 20.4928 13.9459C20.4397 14.1921 20.341 14.4248 20.2023 14.6306Z",fill:"white"})})}function B4(){return a("svg",{width:"26",height:"20",viewBox:"0 0 26 20",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:a("path",{d:"M24.765 5.73805C24.5817 5.57824 24.3551 5.4765 24.1138 5.44576C23.8726 5.41502 23.6277 5.45666 23.4102 5.56539L18.3107 8.10445L14.0532 1.03266C13.9438 0.85119 13.7893 0.70108 13.6048 0.596881C13.4202 0.492681 13.2119 0.437927 13 0.437927C12.7881 0.437927 12.5798 0.492681 12.3952 0.596881C12.2107 0.70108 12.0562 0.85119 11.9468 1.03266L7.68929 8.1075L2.59187 5.56844C2.37487 5.46067 2.13088 5.41939 1.89051 5.44979C1.65014 5.48018 1.4241 5.58089 1.24076 5.73928C1.05742 5.89767 0.924938 6.10669 0.859951 6.34009C0.794963 6.5735 0.80036 6.8209 0.875465 7.05125L4.63328 18.5644C4.67106 18.68 4.73434 18.7857 4.81844 18.8737C4.90254 18.9616 5.00532 19.0295 5.11919 19.0724C5.23305 19.1153 5.3551 19.1321 5.47632 19.1215C5.59753 19.1109 5.71482 19.0732 5.81953 19.0113C5.84492 18.996 8.44187 17.5 13 17.5C17.5581 17.5 20.1551 18.996 20.1784 19.0102C20.2832 19.0728 20.4007 19.111 20.5222 19.122C20.6437 19.1329 20.7661 19.1164 20.8804 19.0735C20.9946 19.0307 21.0978 18.9627 21.1821 18.8746C21.2665 18.7864 21.3299 18.6804 21.3677 18.5644L25.1255 7.0543C25.2028 6.82388 25.2098 6.57569 25.1456 6.3413C25.0814 6.10692 24.9489 5.89692 24.765 5.73805ZM17.8587 13.925C17.8256 14.113 17.7273 14.2832 17.5812 14.406C17.435 14.5287 17.2503 14.5961 17.0595 14.5963C17.0118 14.5963 16.9642 14.5922 16.9173 14.5841C14.322 14.1386 11.6698 14.1386 9.07461 14.5841C8.96951 14.6027 8.86179 14.6003 8.75759 14.5772C8.6534 14.5542 8.55478 14.5108 8.46735 14.4496C8.29079 14.3259 8.17056 14.1373 8.13312 13.925C8.09568 13.7127 8.14409 13.4943 8.2677 13.3177C8.39132 13.1412 8.58001 13.021 8.79226 12.9835C11.5743 12.5055 14.4175 12.5055 17.1996 12.9835C17.3051 13.0016 17.4059 13.0403 17.4964 13.0974C17.5869 13.1545 17.6652 13.229 17.7268 13.3165C17.7884 13.4039 17.8322 13.5027 17.8555 13.6072C17.8788 13.7116 17.8813 13.8196 17.8628 13.925H17.8587Z",fill:"white"})})}function H4(){return a("svg",{width:"23",height:"23",viewBox:"0 0 23 23",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:a("path",{d:"M16.3654 10.6154C16.3654 11.5777 16.08 12.5183 15.5454 13.3184C15.0108 14.1186 14.2509 14.7422 13.3619 15.1104C12.4729 15.4787 11.4946 15.575 10.5508 15.3873C9.60702 15.1995 8.74009 14.7362 8.05966 14.0557C7.37922 13.3753 6.91584 12.5084 6.72811 11.5646C6.54037 10.6208 6.63673 9.64251 7.00497 8.75348C7.37322 7.86445 7.99683 7.10458 8.79694 6.56996C9.59705 6.03535 10.5377 5.75 11.5 5.75C12.7899 5.75146 14.0266 6.26453 14.9387 7.17665C15.8509 8.08877 16.3639 9.32545 16.3654 10.6154ZM23 11.5C23 13.7745 22.3255 15.9979 21.0619 17.8891C19.7983 19.7802 18.0022 21.2542 15.9009 22.1246C13.7995 22.995 11.4872 23.2228 9.25646 22.779C7.02568 22.3353 4.97658 21.24 3.36828 19.6317C1.75997 18.0234 0.664704 15.9743 0.220974 13.7435C-0.222756 11.5128 0.00498277 9.20049 0.87539 7.09914C1.7458 4.99779 3.21978 3.20174 5.11095 1.9381C7.00211 0.674463 9.22552 0 11.5 0C14.549 0.0032198 17.4722 1.21586 19.6282 3.37183C21.7841 5.5278 22.9968 8.451 23 11.5ZM21.2308 11.5C21.2294 10.1903 20.9638 8.89424 20.45 7.68947C19.9363 6.4847 19.1848 5.39592 18.2406 4.48824C17.2963 3.58056 16.1788 2.87263 14.9547 2.40677C13.7306 1.94092 12.4251 1.72672 11.1163 1.77697C5.90813 1.97822 1.75486 6.31615 1.76924 11.5276C1.77423 13.9001 2.64923 16.1883 4.22847 17.9588C4.87161 17.026 5.68857 16.2259 6.63462 15.6024C6.71528 15.5491 6.81117 15.5237 6.90762 15.5301C7.00408 15.5365 7.09578 15.5743 7.16871 15.6378C8.37087 16.6776 9.90722 17.2498 11.4967 17.2498C13.0862 17.2498 14.6225 16.6776 15.8247 15.6378C15.8976 15.5743 15.9893 15.5365 16.0857 15.5301C16.1822 15.5237 16.2781 15.5491 16.3588 15.6024C17.306 16.2256 18.1241 17.0257 18.7682 17.9588C20.3553 16.1819 21.232 13.8825 21.2308 11.5Z",fill:"white"})})}function U4(){return a("svg",{xmlns:"http://www.w3.org/2000/svg",width:"22",height:"21",fill:"none",viewBox:"0 0 22 21",children:a("path",{fill:"#fff",d:"M21.45 9.566l-4.426 3.827 1.326 5.698a1.542 1.542 0 01-.606 1.611 1.58 1.58 0 01-1.734.075l-5.016-3.015-5.006 3.015a1.581 1.581 0 01-1.734-.075 1.542 1.542 0 01-.606-1.612L4.972 13.4.545 9.566a1.542 1.542 0 01.05-2.397c.242-.19.536-.306.844-.332l5.836-.5L9.553.954c.119-.283.32-.524.576-.694a1.576 1.576 0 012.313.694l2.285 5.383 5.834.5c.308.026.602.141.844.331.243.19.423.448.518.74a1.542 1.542 0 01-.468 1.658h-.005z"})})}var V4="./assets/background-lobby.6a04b488.png";function W4(e){return Ie({tag:"svg",attr:{viewBox:"0 0 640 512"},child:[{tag:"path",attr:{d:"M528 448H112c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h416c8.8 0 16-7.2 16-16v-32c0-8.8-7.2-16-16-16zm64-320c-26.5 0-48 21.5-48 48 0 7.1 1.6 13.7 4.4 19.8L476 239.2c-15.4 9.2-35.3 4-44.2-11.6L350.3 85C361 76.2 368 63 368 48c0-26.5-21.5-48-48-48s-48 21.5-48 48c0 15 7 28.2 17.7 37l-81.5 142.6c-8.9 15.6-28.9 20.8-44.2 11.6l-72.3-43.4c2.7-6 4.4-12.7 4.4-19.8 0-26.5-21.5-48-48-48S0 149.5 0 176s21.5 48 48 48c2.6 0 5.2-.4 7.7-.8L128 416h384l72.3-192.8c2.5.4 5.1.8 7.7.8 26.5 0 48-21.5 48-48s-21.5-48-48-48z"}}]})(e)}function G4(e){return Ie({tag:"svg",attr:{viewBox:"0 0 576 512"},child:[{tag:"path",attr:{d:"M259.3 17.8L194 150.2 47.9 171.5c-26.2 3.8-36.7 36.1-17.7 54.6l105.7 103-25 145.5c-4.5 26.3 23.2 46 46.4 33.7L288 439.6l130.7 68.7c23.2 12.2 50.9-7.4 46.4-33.7l-25-145.5 105.7-103c19-18.5 8.5-50.8-17.7-54.6L382 150.2 316.7 17.8c-11.7-23.6-45.6-23.9-57.4 0z"}}]})(e)}function Q4(e){return Ie({tag:"svg",attr:{viewBox:"0 0 448 512"},child:[{tag:"path",attr:{d:"M432 32H312l-9.4-18.7A24 24 0 0 0 281.1 0H166.8a23.72 23.72 0 0 0-21.4 13.3L136 32H16A16 16 0 0 0 0 48v32a16 16 0 0 0 16 16h416a16 16 0 0 0 16-16V48a16 16 0 0 0-16-16zM53.2 467a48 48 0 0 0 47.9 45h245.8a48 48 0 0 0 47.9-45L416 128H32z"}}]})(e)}function Qd(e){return Ie({tag:"svg",attr:{viewBox:"0 0 640 512"},child:[{tag:"path",attr:{d:"M96 224c35.3 0 64-28.7 64-64s-28.7-64-64-64-64 28.7-64 64 28.7 64 64 64zm448 0c35.3 0 64-28.7 64-64s-28.7-64-64-64-64 28.7-64 64 28.7 64 64 64zm32 32h-64c-17.6 0-33.5 7.1-45.1 18.6 40.3 22.1 68.9 62 75.1 109.4h66c17.7 0 32-14.3 32-32v-32c0-35.3-28.7-64-64-64zm-256 0c61.9 0 112-50.1 112-112S381.9 32 320 32 208 82.1 208 144s50.1 112 112 112zm76.8 32h-8.3c-20.8 10-43.9 16-68.5 16s-47.6-6-68.5-16h-8.3C179.6 288 128 339.6 128 403.2V432c0 26.5 21.5 48 48 48h288c26.5 0 48-21.5 48-48v-28.8c0-63.6-51.6-115.2-115.2-115.2zm-223.7-13.4C161.5 263.1 145.6 256 128 256H64c-35.3 0-64 28.7-64 64v32c0 17.7 14.3 32 32 32h65.9c6.3-47.4 34.9-87.3 75.2-109.4z"}}]})(e)}const Y4=E.div`
  height: 74.25vh;
  width: 68.75vw;
  display: grid;
  grid-template-columns: 3.3vw;
  grid-template-rows: 7vh;
  grid-column-gap: 0.75vw;
  grid-row-gap: 1.25vh;
`,K4=E.div`
  position: absolute;
  top: 50%;
  left: 47.5%;
  transform: translate(-50%, -50%);
`,Z4=E.div`
  position: relative;
  height: 100vh;
  width: 100vw;
  background: url(${V4});
`;function pr({children:e}){return a(Z4,{children:a(K4,{children:v(Y4,{children:[v(j4,{children:[a(bn,{to:"/Lobby/Gamemodes",className:`explore ${location.pathname.includes("Gamemodes")&&"selected"}`,children:a(D4,{})}),a(bn,{to:"/Lobby/Profile",className:`explore ${location.pathname.endsWith("Profile")&&"selected"}`,children:a(H4,{})}),a(bn,{to:"/Lobby/Ranking",className:`explore ${location.pathname.endsWith("Ranking")&&"selected"}`,children:a(B4,{})}),a(bn,{to:"/Lobby/Teams",className:`explore ${location.pathname.endsWith("Teams")&&"selected"}`,children:a(Qd,{})}),a(bn,{to:"/Lobby/Ranks",className:`explore ${location.pathname.includes("Ranks")&&"selected"}`,children:a(U4,{})})]}),e]})})})}function X4({...e}){return a("svg",{width:"19",height:"15",viewBox:"0 0 19 15",fill:"none",xmlns:"http://www.w3.org/2000/svg",...e,children:a("path",{d:"M16.7188 0.28125H2.28125C1.93315 0.28125 1.59931 0.419531 1.35317 0.665672C1.10703 0.911814 0.96875 1.24565 0.96875 1.59375V13.4062C0.96875 13.7543 1.10703 14.0882 1.35317 14.3343C1.59931 14.5805 1.93315 14.7188 2.28125 14.7188H16.7188C17.0668 14.7188 17.4007 14.5805 17.6468 14.3343C17.893 14.0882 18.0312 13.7543 18.0312 13.4062V1.59375C18.0312 1.24565 17.893 0.911814 17.6468 0.665672C17.4007 0.419531 17.0668 0.28125 16.7188 0.28125ZM11.7969 4.21875C11.9916 4.21875 12.1819 4.27648 12.3438 4.38465C12.5056 4.49281 12.6318 4.64655 12.7063 4.82642C12.7808 5.00629 12.8003 5.20422 12.7623 5.39517C12.7244 5.58612 12.6306 5.76152 12.4929 5.89918C12.3553 6.03685 12.1799 6.1306 11.9889 6.16859C11.798 6.20657 11.6 6.18707 11.4202 6.11257C11.2403 6.03806 11.0866 5.91189 10.9784 5.75001C10.8702 5.58813 10.8125 5.39782 10.8125 5.20312C10.8125 4.94205 10.9162 4.69167 11.1008 4.50707C11.2854 4.32246 11.5358 4.21875 11.7969 4.21875ZM2.28125 13.4062V11.1094L6.54688 6.84375L13.1094 13.4062H2.28125ZM16.7188 13.4062H14.9657L12.0126 10.4531L13.6532 8.8125L16.7188 11.8788V13.4062Z",fill:"white"})})}var J4="./assets/BRONZE.9a129c62.png",q4="./assets/OURO.dec99c4d.png",e3="./assets/PLATINA.ce357e3c.png",t3="./assets/PRATA.ce0d2e6b.png",n3="./assets/DIAMANTE.9a776439.png",r3="./assets/MESTRE.bfd3abb2.png",i3="./assets/IMORTAL.66a8bfca.png";const Rn=E.img`
  height: 2.5vh;
  width: 2.5vh;
`;function o3(e){return a(Rn,{src:J4,alt:"Bronze",...e})}function l3(e){return a(Rn,{src:q4,alt:"Gold",...e})}function a3(e){return a(Rn,{src:t3,alt:"Silver",...e})}function s3(e){return a(Rn,{src:e3,alt:"Platinum",...e})}function u3(e){return a(Rn,{src:n3,alt:"Diamond",...e})}function c3(e){return a(Rn,{src:r3,alt:"Master",...e})}function d3(e){return a(Rn,{src:i3,alt:"Immortal",...e})}function Qe({rank:e,...t}){switch(e){case"bronze":return a(o3,{...t});case"silver":return a(a3,{...t});case"gold":return a(l3,{...t});case"platinum":return a(s3,{...t});case"diamond":return a(u3,{...t});case"immortal":return a(d3,{...t});case"master":return a(c3,{...t});default:return a(tl,{})}}function Yd(e){switch(e){case"bronze":return"Bronze";case"silver":return"Prata";case"gold":return"Ouro";case"platinum":return"Platina";case"diamond":return"Diamante";case"immortal":return"Imortal";case"master":return"Mestre";default:return""}}function f3(e){switch(e){case"bronze":return"linear-gradient(270deg, rgba(197, 122, 76, 0.11) 0%, rgba(197, 122, 76, 0) 100%)";case"silver":return"linear-gradient(270deg, rgba(255, 255, 255, 0.11) 0%, rgba(146, 197, 255, 0) 100%)";case"gold":return"linear-gradient(270deg, rgba(197, 169, 76, 0.11) 0%, rgba(197, 122, 76, 0) 100%)";case"platinum":return"linear-gradient(270deg, rgba(146, 197, 255, 0.11) 0%, rgba(146, 197, 255, 0) 100%)";case"diamond":return"linear-gradient(270deg, rgba(0, 4, 255, 0.11) 0%, rgba(255, 255, 255, 0) 100%)";case"immortal":return"linear-gradient(270deg, rgba(255, 0, 0, 0.11) 0%, rgba(255, 255, 255, 0) 100%)";case"master":return"linear-gradient(270deg, rgba(30, 255, 0, 0.11) 0%, rgba(255, 255, 255, 0) 100%)";default:return""}}function Kd(e){switch(e){case"bronze":return"#C57A4C";case"silver":return"#777777";case"gold":return"#e9c345";case"platinum":return"#6DB1FD";case"diamond":return"#6e71ff";case"immortal":return"#FF4800";case"master":return"#00FF55";default:return""}}const ll=E.svg`
  margin-right: 0.25vw;
  height: 1.75vh;
  width: 1.75vh;
`;function Zd(){return a(ll,{width:"16",height:"16",viewBox:"0 0 16 16",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:a("path",{d:"M10.847 6.34695L9.19532 8L10.8491 9.65305C11.0076 9.81155 11.0966 10.0265 11.0966 10.2507C11.0966 10.4749 11.0076 10.6899 10.8491 10.8484C10.6906 11.0069 10.4756 11.0959 10.2514 11.0959C10.0272 11.0959 9.81226 11.0069 9.65375 10.8484L8 9.19531L6.34696 10.8491C6.18845 11.0076 5.97346 11.0966 5.7493 11.0966C5.52514 11.0966 5.31015 11.0076 5.15164 10.8491C4.99314 10.6906 4.90409 10.4756 4.90409 10.2514C4.90409 10.0272 4.99314 9.81226 5.15164 9.65375L6.80469 8L5.15305 6.34695C5.07456 6.26847 5.01231 6.17529 4.96983 6.07275C4.92735 5.9702 4.90549 5.86029 4.90549 5.7493C4.90549 5.52513 4.99454 5.31015 5.15305 5.15164C5.31156 4.99313 5.52654 4.90408 5.75071 4.90408C5.97487 4.90408 6.18985 4.99313 6.34836 5.15164L8 6.80469L9.65305 5.15094C9.81156 4.99243 10.0265 4.90338 10.2507 4.90338C10.4749 4.90338 10.6899 4.99243 10.8484 5.15094C11.0069 5.30945 11.0959 5.52443 11.0959 5.74859C11.0959 5.97276 11.0069 6.18774 10.8484 6.34625L10.847 6.34695ZM15.5938 8C15.5938 9.5019 15.1484 10.9701 14.314 12.2189C13.4796 13.4676 12.2936 14.441 10.906 15.0157C9.51843 15.5905 7.99158 15.7408 6.51854 15.4478C5.04549 15.1548 3.69242 14.4316 2.63041 13.3696C1.56841 12.3076 0.845172 10.9545 0.552165 9.48147C0.259159 8.00842 0.40954 6.48157 0.984293 5.094C1.55905 3.70642 2.53236 2.52044 3.78114 1.68603C5.02993 0.851616 6.4981 0.40625 8 0.40625C10.0133 0.408483 11.9435 1.20925 13.3671 2.63287C14.7907 4.0565 15.5915 5.9867 15.5938 8ZM13.9063 8C13.9063 6.83185 13.5599 5.68994 12.9109 4.71866C12.2619 3.74739 11.3395 2.99037 10.2602 2.54334C9.181 2.09631 7.99345 1.97934 6.84775 2.20724C5.70205 2.43513 4.64966 2.99765 3.82365 3.82365C2.99765 4.64965 2.43513 5.70205 2.20724 6.84775C1.97935 7.99345 2.09631 9.181 2.54334 10.2602C2.99037 11.3394 3.74739 12.2619 4.71867 12.9109C5.68994 13.5599 6.83186 13.9062 8 13.9062C9.56592 13.9046 11.0672 13.2818 12.1745 12.1745C13.2818 11.0672 13.9046 9.56592 13.9063 8Z",fill:"white","fill-opacity":"0.5"})})}function Xd(){return a(ll,{width:"18",height:"15",viewBox:"0 0 18 15",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:a("path",{d:"M16.3125 2.21875H14.9062V1.9375C14.9063 1.56454 14.7581 1.20685 14.4944 0.943131C14.2306 0.679408 13.873 0.53125 13.5 0.53125H4.5C4.12704 0.53125 3.76935 0.679408 3.50563 0.943131C3.24191 1.20685 3.09375 1.56454 3.09375 1.9375V2.21875H1.6875C1.50283 2.21875 1.31997 2.25512 1.14935 2.32579C0.978737 2.39646 0.823713 2.50005 0.693131 2.63063C0.429408 2.89435 0.28125 3.25204 0.28125 3.625V4.75C0.28218 5.57023 0.608427 6.35659 1.18842 6.93658C1.76841 7.51657 2.55477 7.84282 3.375 7.84375H3.42914C3.78951 8.85914 4.42021 9.7569 5.25323 10.4402C6.08625 11.1236 7.09 11.5666 8.15625 11.7215V12.9062H6.75C6.52622 12.9062 6.31161 12.9951 6.15338 13.1534C5.99514 13.3116 5.90625 13.5262 5.90625 13.75C5.90625 13.9738 5.99514 14.1884 6.15338 14.3466C6.31161 14.5049 6.52622 14.5938 6.75 14.5938H11.25C11.4738 14.5937 11.6884 14.5049 11.8466 14.3466C12.0049 14.1884 12.0938 13.9738 12.0938 13.75C12.0938 13.5262 12.0049 13.3116 11.8466 13.1534C11.6884 12.9951 11.4738 12.9062 11.25 12.9062H9.84375V11.7187C12.0192 11.4016 13.8185 9.87648 14.5547 7.84375H14.625C15.4452 7.84282 16.2316 7.51657 16.8116 6.93658C17.3916 6.35659 17.7178 5.57023 17.7188 4.75V3.625C17.7188 3.25204 17.5706 2.89435 17.3069 2.63063C17.0431 2.36691 16.6855 2.21875 16.3125 2.21875ZM1.96875 4.75V3.90625H3.09375V5.875C3.09375 5.96008 3.09375 6.04445 3.10008 6.12883C2.78116 6.06525 2.49413 5.89311 2.28786 5.64171C2.08159 5.39031 1.96882 5.07519 1.96875 4.75ZM13.2188 5.81172C13.2188 8.15523 11.3407 10.0762 9.03234 10.0938C8.47561 10.098 7.92355 9.99205 7.40796 9.78195C6.89238 9.57185 6.42349 9.26177 6.02831 8.8696C5.63313 8.47743 5.31948 8.01091 5.10545 7.49695C4.89142 6.98299 4.78123 6.43175 4.78125 5.875V2.21875H13.2188V5.81172ZM16.0312 4.75C16.0312 5.07561 15.9183 5.39113 15.7115 5.64272C15.5048 5.8943 15.2172 6.06636 14.8978 6.12953C14.9034 6.02406 14.9062 5.91859 14.9062 5.81172V3.90625H16.0312V4.75Z",fill:"white","fill-opacity":"0.5"})})}function Jd(){return a(ll,{width:"16",height:"17",viewBox:"0 0 16 17",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:a("path",{d:"M7.15625 9.28125C7.15625 9.61501 7.05728 9.94127 6.87185 10.2188C6.68643 10.4963 6.42288 10.7126 6.11453 10.8403C5.80618 10.968 5.46688 11.0014 5.13954 10.9363C4.81219 10.8712 4.51151 10.7105 4.27551 10.4745C4.03951 10.2385 3.87879 9.93781 3.81367 9.61047C3.74856 9.28312 3.78198 8.94382 3.9097 8.63547C4.03743 8.32712 4.25372 8.06357 4.53123 7.87815C4.80873 7.69272 5.13499 7.59375 5.46875 7.59375C5.9163 7.59375 6.34553 7.77154 6.66199 8.08801C6.97846 8.40447 7.15625 8.8337 7.15625 9.28125ZM10.5312 7.59375C10.1975 7.59375 9.87123 7.69272 9.59373 7.87815C9.31622 8.06357 9.09993 8.32712 8.9722 8.63547C8.84448 8.94382 8.81106 9.28312 8.87617 9.61047C8.94129 9.93781 9.10201 10.2385 9.33801 10.4745C9.57401 10.7105 9.87469 10.8712 10.202 10.9363C10.5294 11.0014 10.8687 10.968 11.177 10.8403C11.4854 10.7126 11.7489 10.4963 11.9344 10.2188C12.1198 9.94127 12.2188 9.61501 12.2188 9.28125C12.2187 8.8337 12.041 8.40447 11.7245 8.08801C11.408 7.77154 10.9788 7.59375 10.5312 7.59375ZM15.5938 8.15625C15.5938 10.2551 14.6762 12.2189 13.0625 13.6069V15.1875C13.0625 15.5605 12.9143 15.9181 12.6506 16.1819C12.3869 16.4456 12.0292 16.5938 11.6562 16.5938H4.34375C3.97079 16.5938 3.6131 16.4456 3.34938 16.1819C3.08566 15.9181 2.9375 15.5605 2.9375 15.1875V13.6069C1.32031 12.2189 0.40625 10.2551 0.40625 8.15625C0.40625 4.12383 3.81289 0.84375 8 0.84375C12.1871 0.84375 15.5938 4.12383 15.5938 8.15625ZM13.9062 8.15625C13.9062 5.05477 11.2569 2.53125 8 2.53125C4.74313 2.53125 2.09375 5.05477 2.09375 8.15625C2.09375 9.86555 2.89602 11.4609 4.29523 12.5367C4.39785 12.6155 4.48096 12.7169 4.53814 12.833C4.59532 12.949 4.62504 13.0767 4.625 13.2061V14.9062H5.75V13.5C5.75 13.2762 5.83889 13.0616 5.99713 12.9034C6.15536 12.7451 6.36997 12.6562 6.59375 12.6562C6.81753 12.6562 7.03214 12.7451 7.19037 12.9034C7.34861 13.0616 7.4375 13.2762 7.4375 13.5V14.9062H8.5625V13.5C8.5625 13.2762 8.6514 13.0616 8.80963 12.9034C8.96786 12.7451 9.18247 12.6562 9.40625 12.6562C9.63003 12.6562 9.84464 12.7451 10.0029 12.9034C10.1611 13.0616 10.25 13.2762 10.25 13.5V14.9062H11.375V13.2061C11.3751 13.0768 11.4048 12.9493 11.462 12.8334C11.5192 12.7174 11.6022 12.6162 11.7048 12.5374C13.104 11.4609 13.9062 9.86555 13.9062 8.15625Z",fill:"white","fill-opacity":"0.5"})})}function qd(){return a(ll,{width:"16",height:"16",viewBox:"0 0 16 16",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:a("path",{d:"M8 0.40625C6.4981 0.40625 5.02993 0.851616 3.78114 1.68603C2.53236 2.52044 1.55905 3.70642 0.984293 5.094C0.40954 6.48157 0.259159 8.00842 0.552165 9.48147C0.845172 10.9545 1.56841 12.3076 2.63041 13.3696C3.69242 14.4316 5.04549 15.1548 6.51854 15.4478C7.99158 15.7408 9.51843 15.5905 10.906 15.0157C12.2936 14.441 13.4796 13.4676 14.314 12.2189C15.1484 10.9701 15.5938 9.5019 15.5938 8C15.5915 5.9867 14.7907 4.0565 13.3671 2.63287C11.9435 1.20925 10.0133 0.408483 8 0.40625ZM8.84375 13.8451V11.9375C8.84375 11.7137 8.75486 11.4991 8.59662 11.3409C8.43839 11.1826 8.22378 11.0938 8 11.0938C7.77623 11.0938 7.56162 11.1826 7.40338 11.3409C7.24515 11.4991 7.15625 11.7137 7.15625 11.9375V13.8451C5.89531 13.6609 4.72747 13.0747 3.82639 12.1736C2.92531 11.2725 2.3391 10.1047 2.15493 8.84375H4.0625C4.28628 8.84375 4.50089 8.75485 4.65912 8.59662C4.81736 8.43839 4.90625 8.22378 4.90625 8C4.90625 7.77622 4.81736 7.56161 4.65912 7.40338C4.50089 7.24514 4.28628 7.15625 4.0625 7.15625H2.15493C2.3391 5.89531 2.92531 4.72747 3.82639 3.82639C4.72747 2.9253 5.89531 2.33909 7.15625 2.15492V4.0625C7.15625 4.28628 7.24515 4.50089 7.40338 4.65912C7.56162 4.81736 7.77623 4.90625 8 4.90625C8.22378 4.90625 8.43839 4.81736 8.59662 4.65912C8.75486 4.50089 8.84375 4.28628 8.84375 4.0625V2.15492C10.1047 2.33909 11.2725 2.9253 12.1736 3.82639C13.0747 4.72747 13.6609 5.89531 13.8451 7.15625H11.9375C11.7137 7.15625 11.4991 7.24514 11.3409 7.40338C11.1826 7.56161 11.0938 7.77622 11.0938 8C11.0938 8.22378 11.1826 8.43839 11.3409 8.59662C11.4991 8.75485 11.7137 8.84375 11.9375 8.84375H13.8451C13.6609 10.1047 13.0747 11.2725 12.1736 12.1736C11.2725 13.0747 10.1047 13.6609 8.84375 13.8451Z",fill:"white","fill-opacity":"0.5"})})}function p3(e){return v("svg",{width:"12",height:"12",viewBox:"0 0 12 12",fill:"none",xmlns:"http://www.w3.org/2000/svg",...e,children:[a("path",{"fill-rule":"evenodd","clip-rule":"evenodd",d:"M10.8 7.2C11.4627 7.2 12 7.73726 12 8.4V10.8C12 11.4627 11.4627 12 10.8 12C10.1373 12 9.6 11.4627 9.6 10.8V8.4C9.6 7.73726 10.1373 7.2 10.8 7.2Z",fill:"white","fill-opacity":"0.5"}),a("path",{"fill-rule":"evenodd","clip-rule":"evenodd",d:"M6 0C6.66274 0 7.2 0.537258 7.2 1.2V10.8C7.2 11.4627 6.66274 12 6 12C5.33726 12 4.8 11.4627 4.8 10.8V1.2C4.8 0.537258 5.33726 0 6 0Z",fill:"white","fill-opacity":"0.5"}),a("path",{"fill-rule":"evenodd","clip-rule":"evenodd",d:"M1.2 4.8C1.86274 4.8 2.4 5.33726 2.4 6V10.8C2.4 11.4627 1.86274 12 1.2 12C0.537258 12 0 11.4627 0 10.8V6C0 5.33726 0.537258 4.8 1.2 4.8Z",fill:"white","fill-opacity":"0.5"})]})}function I1(){return a("svg",{width:"9",height:"5",viewBox:"0 0 9 5",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:a("path",{d:"M1 1L4.5 4L8 1",stroke:"white","stroke-width":"1.5","stroke-linecap":"round","stroke-linejoin":"round"})})}function h3(){return a("svg",{width:"12",height:"12",viewBox:"0 0 12 12",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:a("path",{d:"M11.4369 0H0.563154C0.0635131 0 -0.188604 0.606234 0.165419 0.960258L4.5 5.29549V10.125C4.5 10.3085 4.58955 10.4805 4.73993 10.5858L6.61493 11.8979C6.98484 12.1568 7.5 11.8944 7.5 11.437V5.29549L11.8347 0.960258C12.188 0.606937 11.9376 0 11.4369 0Z",fill:"white"})})}const Qa=E.div`
  table {
    width: 100%;
    font-family: 'Poppins';
    background-color: rgba(255, 255, 255, 0.04);
    border-radius: 0.75vw;
    font-size: 0.8vw;

    padding: 0.75vh 0.75vh;
  
    border-spacing: 0;
  }

  tbody {
    tr:first-child td:first-child { border-top-left-radius: 10px; }
    tr:first-child td:last-child { border-top-right-radius: 10px; }

    tr:last-child td:first-child { border-bottom-left-radius: 10px; }
    tr:last-child td:last-child { border-bottom-right-radius: 10px; }

    tr {
      height: 3.25vh;
      text-align: center;
      color: rgba(255, 255, 255, 0.5);
      font-weight: 500;

      background: rgba(255, 255, 255, 0.01);
      border-radius: 0.5vw;
      
      &:nth-child(even) {
        background: rgba(255, 255, 255, 0.03);
      }

      td {
        position: relative;
        vertical-align: middle;
      }
    }

    &::before {
      content: '';
      display: block;
      height: 1vh;;
    }
  }

  thead {
    height: 4vh;
    tr {
      background-color: rgba(255, 255, 255, 0.04);
      th {
        text-align: center;
        vertical-align: middle;
        text-transform: uppercase;

        color: rgba(255, 255, 255, 0.5);
        padding: 0vh 1vw;
        margin: 0;
        outline: 0;
        box-sizing: border-box;

        .rev {
          height: 100%;
          width: 100%;
          display: flex;
          justify-content: center;
          align-items: center;
          font-size: 1.5vh;
          line-height: 1.5vh;
        }

        &:first-child {
          border-top-left-radius: 0.5vw;
          border-bottom-left-radius: 0.5vw;
        }

        &:last-child {
          border-top-right-radius: 0.5vw;
          border-bottom-right-radius: 0.5vw;
        }
      }
    }
  }
`;function ef(e){return a("svg",{width:"19",height:"19",viewBox:"0 0 19 19",fill:"none",xmlns:"http://www.w3.org/2000/svg",...e,children:a("path",{d:"M9.5 0.15625C7.65198 0.15625 5.84547 0.704251 4.30889 1.73096C2.77232 2.75766 1.57471 4.21695 0.867505 5.9243C0.160299 7.63165 -0.0247389 9.51037 0.335792 11.3229C0.696322 13.1354 1.58623 14.8003 2.89298 16.107C4.19972 17.4138 5.86462 18.3037 7.67713 18.6642C9.48964 19.0247 11.3684 18.8397 13.0757 18.1325C14.783 17.4253 16.2423 16.2277 17.269 14.6911C18.2958 13.1545 18.8438 11.348 18.8438 9.5C18.8411 7.02269 17.8559 4.64759 16.1041 2.89586C14.3524 1.14413 11.9773 0.158866 9.5 0.15625ZM9.5 17.4062C7.9363 17.4062 6.4077 16.9426 5.10753 16.0738C3.80735 15.2051 2.79399 13.9703 2.19558 12.5256C1.59718 11.0809 1.44061 9.49123 1.74567 7.95757C2.05073 6.4239 2.80373 5.01515 3.90944 3.90944C5.01515 2.80373 6.42391 2.05073 7.95757 1.74567C9.49123 1.4406 11.0809 1.59717 12.5256 2.19558C13.9703 2.79398 15.2051 3.80735 16.0738 5.10752C16.9426 6.4077 17.4063 7.93629 17.4063 9.5C17.4039 11.5961 16.5701 13.6057 15.0879 15.0879C13.6057 16.5701 11.5961 17.4039 9.5 17.4062ZM13.6023 8.99148C13.6691 9.05824 13.7221 9.13751 13.7583 9.22476C13.7945 9.31202 13.8131 9.40555 13.8131 9.5C13.8131 9.59445 13.7945 9.68798 13.7583 9.77524C13.7221 9.86249 13.6691 9.94176 13.6023 10.0085L10.7273 12.8835C10.5924 13.0184 10.4095 13.0942 10.2188 13.0942C10.028 13.0942 9.84511 13.0184 9.71024 12.8835C9.57537 12.7486 9.4996 12.5657 9.4996 12.375C9.4996 12.1843 9.57537 12.0014 9.71024 11.8665L11.3589 10.2188H5.90625C5.71563 10.2188 5.53281 10.143 5.39802 10.0082C5.26323 9.87344 5.1875 9.69062 5.1875 9.5C5.1875 9.30938 5.26323 9.12656 5.39802 8.99177C5.53281 8.85698 5.71563 8.78125 5.90625 8.78125H11.3589L9.71024 7.13352C9.57537 6.99865 9.4996 6.81573 9.4996 6.625C9.4996 6.43427 9.57537 6.25135 9.71024 6.11648C9.84511 5.98162 10.028 5.90585 10.2188 5.90585C10.4095 5.90585 10.5924 5.98162 10.7273 6.11648L13.6023 8.99148Z",fill:"#F20A45"})})}function m3(){return a(ef,{style:{transform:"rotate(180deg)"}})}const g3=E.div`
  display: flex;
  font-family: 'Poppins';
  font-size: 0.75vw;

  b {
    margin: 0 0.2vw;
    color: #F20A45;
  }

  button {
    margin: 0 0.2vw;
    background: none;
    border: none;
    cursor: pointer;
    outline: none;
  }
`;function v3({onPageChange:e,page:t,totalPages:n}){const r=i=>{i<1||i>n||e(i)};return v(g3,{children:["p\xE1gina",a("b",{children:t}),"de",a("b",{children:n}),t-1>=1&&a("button",{onClick:()=>r(t-1),children:a(m3,{})}),t+1<=n&&a("button",{onClick:()=>r(t+1),children:a(ef,{})})]})}function y3(e,t){if(e===0){const l=t.every(u=>u.isSelected);return t.map(u=>({...u,isSelected:!l}))}const n=[...t],r=n[e].isSelected;r&&(n[0].isSelected=!1),n[e].isSelected=!r;const[,...i]=n;return i.every(l=>l.isSelected)&&(n[0].isSelected=!0),n}const Dl={data:{avatarUrl:"https://media.discordapp.net/attachments/1008191296030117948/1088245715203014706/FryVtBkWcAIyTIJ.png",backgroundUrl:"https://media.discordapp.net/attachments/1008191296030117948/1088320707538202745/image.png",isOnline:!0,name:"Self Rafael",id:1},ranks:[{deaths:0,kills:0,gamemode:"Battle Royale",position:1,rank:"bronze",wins:0,losses:0},{deaths:0,kills:0,gamemode:"Modo 1v1",position:2,rank:"bronze",wins:0,losses:0},{deaths:0,kills:0,gamemode:"Modo 2v2",position:3,rank:"bronze",wins:0,losses:0},{deaths:0,kills:0,gamemode:"Modo 3v3",position:4,rank:"bronze",wins:0,losses:0},{deaths:0,kills:0,gamemode:"Modo 4v4",position:5,rank:"bronze",wins:0,losses:0}]},w3={data:{avatarUrl:"https://media.discordapp.net/attachments/1008191296030117948/1088245715203014706/FryVtBkWcAIyTIJ.png",backgroundUrl:"https://media.discordapp.net/attachments/1008191296030117948/1088320707538202745/image.png",isOnline:!1,name:"Non Self Rafael",id:1},ranks:[{deaths:0,kills:0,gamemode:"Battle Royale",position:0,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"},{deaths:0,kills:0,gamemode:"Modo 1v1",position:0,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"},{deaths:0,kills:0,gamemode:"Modo 2v2",position:0,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"},{deaths:0,kills:0,gamemode:"Modo 3v3",position:0,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"},{deaths:0,kills:0,gamemode:"Modo 4v4",position:0,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"}]},x3={["Battle Royale"]:{totalPages:10,data:[{deaths:0,kills:0,gamemode:"Battle Royale",position:1,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"},{deaths:0,kills:0,gamemode:"Modo 1v1",position:2,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"},{deaths:0,kills:0,gamemode:"Modo 2v2",position:3,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"},{deaths:0,kills:0,gamemode:"Modo 3v3",position:4,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"},{deaths:0,kills:0,gamemode:"Modo 4v4",position:5,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"},{deaths:0,kills:0,gamemode:"Modo 4v4",position:6,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"},{deaths:0,kills:0,gamemode:"Modo 4v4",position:7,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"},{deaths:0,kills:0,gamemode:"Modo 4v4",position:8,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"},{deaths:0,kills:0,gamemode:"Modo 4v4",position:9,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"},{deaths:0,kills:0,gamemode:"Modo 4v4",position:10,rank:"bronze",wins:0,losses:0,id:1,name:"Rafael"}]}};function C3(e,t){const n=[];for(let r=0;r<10;r++)n.push({deaths:0,kills:0,gamemode:e,position:0,rank:"bronze",wins:0,losses:0,id:1,name:`GAMEMODE-> ${e} PAGE-> ${t} INDEX -> ${r}`});return{totalPages:Math.floor(Math.random()*10)+2,data:n}}const F1=10,tf=x.exports.createContext(null);function k3({children:e}){const[t,n]=x.exports.useState(Dl),[r,i]=x.exports.useState(Dl),[o,l]=x.exports.useState([]),[s,u]=x.exports.useState(x3),[c,p]=x.exports.useState(["Battle Royale","Modo 1v1","Modo 2v2","Modo 3v3","Modo 4v4"]),g=(f,d=1,h=F1)=>{const k=(d-1)*h,z=k+h;return{...f,data:f.data.slice(k,z)}},m=async(f,d=1,h=F1)=>{const k=s[f];if(k&&k.data.length>=d*h)return g({...s[f]},d,h);var z;lr()&&(z=await C3(f,d));const{data:_,totalPages:M}=await We("requestRank",{gamemode:f,page:d,itemsPerPage:h},z);var b;if(k){const V=k.data||[];_.forEach(I=>{V.push(I)}),b={...k,data:V}}else b={data:_,totalPages:M};return u({[f]:b,...s}),g(b,d,h)},C=async f=>(delete s[f],await m(f)),y=async f=>{if(!f){const h=await We("requestSelfProfile",{},Dl);return i(h),h}const d=await We("requestProfile",{id:f},w3);return i(d),d},w=async(f,d)=>await We("requestUserRanking",{gamemode:d,id:f},[{deaths:0,kills:0,gamemode:d,position:0,rank:"bronze",wins:0,losses:0,id:f,name:`MOCK SEARCH USER GAMEMODE-> ${d}`}]),P=async()=>{const f=await We("requestGamemodes",{},[{allowed:"all",mode:"Battle Royale",location:"Los Santos",max:32,min:2,uuid:"1234567890"}]);return l(f),p(f.map(d=>d.mode)),f};return a(tf.Provider,{value:{selfProfile:t,profile:r,gamemodes:o,globalRankCache:s,disponibleGamemodes:c,refreshGlobalRankGamemode:m,refreshGlobalWithNewData:C,refreshProfileWithNewData:y,searchUserRanking:w,setSelfProfile:n,refreshDisponibleGamemodes:P},children:e})}const ru=()=>x.exports.useContext(tf);function S3(){return a("svg",{xmlns:"http://www.w3.org/2000/svg",width:"8",height:"9",fill:"none",viewBox:"0 0 6 8",style:{marginLeft:"0.1rem"},children:a("path",{fill:"#fff",fillRule:"evenodd",d:"M.955.625L5.5 3.75c.15.104.181.3.068.438a.328.328 0 01-.068.062L.955 7.375a.362.362 0 01-.478-.063.296.296 0 01-.068-.187V.875C.41.702.562.562.75.562c.074 0 .146.022.205.063z",clipRule:"evenodd"})})}function E3(){return a("svg",{xmlns:"http://www.w3.org/2000/svg",width:"10",height:"10",fill:"none",viewBox:"0 0 10 10",children:a("path",{fill:"#fff",d:"M6.425 7.642a.312.312 0 01-.262.483H.4a.313.313 0 01-.262-.483 3.743 3.743 0 011.844-1.473 2.344 2.344 0 112.598 0c.758.279 1.405.796 1.845 1.473zm3.434-.006a3.745 3.745 0 00-1.841-1.467 2.344 2.344 0 00-2.366-4.037.156.156 0 00-.052.235 2.962 2.962 0 01.142 3.513.156.156 0 00.042.216c.462.323.858.732 1.166 1.204.124.19.175.42.143.644a.156.156 0 00.154.181h2.355a.313.313 0 00.302-.232.321.321 0 00-.045-.257z"})})}function P3(){return a("svg",{xmlns:"http://www.w3.org/2000/svg",width:"10",height:"10",fill:"none",viewBox:"0 0 10 10",children:a("path",{fill:"#F20A45",d:"M9.665 6.787v-.005l-.64-3.288v-.007A2.347 2.347 0 006.72 1.562H3.277A2.34 2.34 0 00.972 3.498L.335 6.782v.005a1.406 1.406 0 002.379 1.239l.014-.015 1.55-1.761h1.445l1.551 1.761.014.015a1.41 1.41 0 001.587.28 1.406 1.406 0 00.79-1.519zM4.063 4.375H3.75v.313a.313.313 0 01-.625 0v-.313h-.313a.312.312 0 110-.625h.313v-.313a.312.312 0 11.625 0v.313h.312a.312.312 0 110 .625zm1.563-.313a.312.312 0 01.312-.312h.938a.312.312 0 110 .625h-.938a.312.312 0 01-.312-.313zM8.92 7.48a.775.775 0 01-.87.299.785.785 0 01-.317-.188l-1.18-1.34h.165A2.344 2.344 0 008.71 5.141L9.052 6.9a.774.774 0 01-.131.58z"})})}function z3(){return a("svg",{xmlns:"http://www.w3.org/2000/svg",width:"9",height:"10",fill:"none",viewBox:"0 0 9 10",children:a("path",{fill:"#fff",d:"M2.4 3.683L8.255.303l.7 1.212-.366.211.175.303-2.196 1.268a.47.47 0 00-.207.238.323.323 0 00.016.276l.175.303c.093.161.105.36.033.553a.942.942 0 01-.415.476l-1.237.714a.444.444 0 00-.231.36l-.041 2a.433.433 0 01-.23.354l-1.237.714s-1.098.634-.683-2.03c0 0 .398-1.845-1.066-1L.57 4.74l.366-.211.008-.41 1.098-.633.358.197zm3.786.643l-.175-.303a.323.323 0 00-.23-.153.47.47 0 00-.31.06l-.367.212s-.19.514.35.606a.942.942 0 01-.62.121.645.645 0 01-.462-.304.47.47 0 00-.207.238.323.323 0 00.016.276l.175.303c.047.08.13.135.231.152a.47.47 0 00.31-.06l1.098-.634a.47.47 0 00.208-.238.323.323 0 00-.017-.276z"})})}function R3(){return a("svg",{xmlns:"http://www.w3.org/2000/svg",width:"10",height:"10",fill:"none",viewBox:"0 0 10 10",children:a("path",{fill:"#fff",d:"M5 .625a3.441 3.441 0 00-3.438 3.438c0 2.94 3.125 5.162 3.259 5.255a.313.313 0 00.358 0c.133-.093 3.258-2.314 3.258-5.255A3.441 3.441 0 005 .624zm0 2.188a1.25 1.25 0 110 2.5 1.25 1.25 0 010-2.5z"})})}const L3=E.div`
    width: 98%;
    height: 15.78rem;
    display: flex;
    flex-direction: column;
    font-size: .4rem;
    padding: 8px;

    background: radial-gradient(87.22% 84.84% at 17.04% 12.91%, rgba(235, 235, 235, 0.03) 0%, rgba(37, 39, 41, 0.12) 100%) /* warning: gradient uses a rotation that is not supported by CSS and may not behave as expected */;
    border-radius: 5px;
`,N3=E.img`
    width: 100%;
    height: 42%;
    object-fit: cover;
    border-radius: 5px 5px 0px 0px;
`,T3=E.div`
    width: 100%;
    height: 60%;
    display: flex;
    justify-content: space-between;
    flex-direction: column;
    background: #161206;
    border-radius: 0px;
    padding: 4px 0px;
`,b3=E.div`
    width: 100%;
    height: 50%;
    display: flex;
    flex-direction: row;
    gap: .5rem;
    padding: 1px 8px;
    background: rgba(183, 183, 183, 0.02);
    border-radius: 4px 4px 0px 0px;

    h2 {
        align-self: center;
        font-weight: 700;
        line-height: 14px;
    }
    h2:first-child {
        color: #F20A45;
    }
`,_3=E.button`
    width: 100%;
    height: 18%;
    display: flex;
    align-items: center;
    justify-content: center;
    border: none;
    background: #F20A45;
    cursor: pointer;
    font-size: .45rem;
    color: #fff;
    text-transform: uppercase;
    transition: all .2s ease-in-out;
    border-radius: 0px 0px 4px 4px;

    h2 {
        font-weight: 800;
        font-family: 'Inter';
    }

    &:disabled {
        background: #E9AE0698;
        cursor: not-allowed;
    }

    &:hover {
        opacity: .65;
    }
`,M3=E.div`
    display: flex;
    align-items: center;
    justify-content: center;
    width: 11.6%;
    height: 80%;
    background: rgba(255, 255, 255, 0.06);
    border-radius: 5px;

    svg {
        width: .9rem;
        height: .9rem;
        color: #fff;
    }
`;function O3({mode:e,location:t,min:n,max:r,allowed:i,uuid:o}){const l=di(),s=[{icon:a(P3,{}),description:e},{icon:a(R3,{}),description:t},{icon:a(E3,{}),description:`${n}/${r}`},{icon:a(z3,{}),description:i}],u=()=>{l(`/Lobby/Teams/Gamemodes/${o}`)};return v(L3,{children:[a(N3,{src:"https://media.discordapp.net/attachments/1008191296030117948/1087815080621649920/Rectangle_456.png"}),a(T3,{children:s.map((c,p)=>v(b3,{children:[a(M3,{children:c.icon}),a("h2",{children:c.description})]},p))}),a(_3,{onClick:u,children:v("h2",{children:["ENTRAR NO JOGO ",a(S3,{})]})})]})}function A3(){const{gamemodes:e,refreshDisponibleGamemodes:t}=ru(),[n,r]=x.exports.useState(e),[i,o]=x.exports.useState([]),[l,s]=x.exports.useState(!1),[u,c]=x.exports.useState("Todos os Modos");x.exports.useEffect(()=>{const C=[...e].map(y=>({text:y.mode,isSelected:!0}));o([{text:"Todos os Modos",isSelected:!0},...C])},[e]);const p=()=>{s(!l)},g=C=>{const y=y3(C,i),w=y.filter(f=>f.isSelected);y[0].isSelected?c("Todos os Modos"):w.length===1?c(w[0].text):c(`${w.length} selecionados`);const P=e.filter(f=>!!w.find(h=>h.text===f.mode));r(P),o(y)},m=async()=>{const C=await t();r(C)};return x.exports.useEffect(()=>{e.length<=0&&m()},[]),v(pr,{children:[v(fr,{text:"modos DE JOGO",children:[a(Vd,{isOpen:l,onClick:p,options:i,text:u,type:"multi",onClickOption:g,style:{minWidth:"12vw"}}),a(il,{onClick:m,style:{marginLeft:"0.5vw"}})]}),a(un,{style:{gridArea:"2 / 2 / 3 / 3"},children:a("div",{style:{display:"grid",gridTemplateColumns:"1fr 1fr 1fr 1fr 1fr",gridGap:"1rem"},children:n.map((C,y)=>x.exports.createElement(O3,{...C,key:y}))})})]})}function $3(){return a("svg",{xmlns:"http://www.w3.org/2000/svg",width:"8",height:"8",fill:"none",viewBox:"0 0 8 8",children:a("path",{fill:"#fff",d:"M1.292 7.043a.334.334 0 01-.317-.227.33.33 0 01-.017-.137l.082-.9L4.82 2l1.181 1.182-3.779 3.78-.9.081c-.01.001-.02.002-.03.001zm4.945-4.099l-1.18-1.18.708-.71a.334.334 0 01.472 0l.709.71a.334.334 0 010 .472l-.709.708z"})})}const I3=E.div`
    width: 1.6rem;
    height: 1.6rem;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(0, 0, 0, 0.7);
    border-radius: 100%;
    margin: 1.1rem;

    :hover {
        cursor: pointer;
    }

    svg {
        width: .8rem;
        height: .8rem;
    }
`;function nf({...e}){return a(I3,{...e,children:a($3,{})})}const F3=E.div`
  position: relative;
  width: max-content;
  height: max-content;
  display: flex;
  flex-direction: column;
  font-size: 0.4rem;
  padding: 8px;
  align-items: flex-end;
  justify-content: flex-end;

  border-radius: 5px;
`,j3=E.div`
  width: 98%;
  height: 82%;
  position: relative;
  display: flex;
  justify-content: space-between;
  top: 59%;
  left: 2.3%;

  .fix-relative {
    position: relative;
    top: 10px;
    left: -50px;
  }
`,D3=E.img`
  width: 12.5vh;
  height: 12.5vh;
  border-radius: 100%;
  border: 0.1vh solid #F20A45;
  object-fit: cover;
  object-position: center center;
`,B3=E.div`
  width: 30%;
  height: 100%;
  display: flex;
  flex-direction: row;
  align-items: flex-end;
`,H3=E.div`
  margin-bottom: 0.4rem;
  h2 {
    color: rgba(255, 255, 255, 0.5);
  }
`,j1=E.div`
  display: flex;
  align-items: baseline;
  gap: 0.4rem;

  h1 {
    font-size: 1.3rem;
  }
`,U3=E.div`
  width: 0.5rem;
  height: 0.5rem;
  border-radius: 100%;
  background-color: ${e=>e.isOnline?"#00FF00":"#FF0000"};
`;function V3({Avatar:e,onClickEdit:t,isEditable:n}){return v(F3,{children:[a(D3,{src:e}),a("div",{style:{position:"absolute",right:"0.5vw",bottom:"0.5vh"},children:n&&a(nf,{onClick:t})})]})}function W3(){return v("svg",{xmlns:"http://www.w3.org/2000/svg",width:"15",height:"15",fill:"none",viewBox:"0 0 15 15",children:[a("path",{fill:"#fff",d:"M3.75 4.688h8.438v5.625H3.75V4.686z"}),a("path",{fill:"#F20A45",d:"M5.182 15l-1.296-2.286-2.454-.571L1.67 9.5 0 7.5l1.67-2-.238-2.643 2.454-.571L5.182 0 7.5 1.036 9.818 0l1.296 2.286 2.454.571L13.33 5.5 15 7.5l-1.67 2 .238 2.643-2.454.571L9.818 15 7.5 13.964 5.182 15zm1.602-4.964L10.636 6l-.954-1.036L6.784 8 5.318 6.5l-.954 1 2.42 2.536z"})]})}const G3=E.div`
    position: relative;
    width: 103%;
    height: 17vh;
    padding: 8px;
    display: flex;
    font-size: .4rem;
    margin: -1vh -1vw;

    background-image: url(
        ${e=>e.Background}
    );
    background-size: 100% auto;
    mix-blend-mode: luminosity;
`;E.img`
    width: 100%;
    height: 42%;
    object-fit: cover;
    border-radius: 5px 5px 0px 0px;
`;function Q3({avatarUrl:e,backgroundUrl:t,isOnline:n,name:r,onClickEditPhotoButton:i,onClickEditBackgroundButton:o,isEditable:l}){return v(G3,{Background:t,children:[a(j3,{children:v(B3,{children:[a(V3,{onClickEdit:i,isEditable:l,Avatar:e}),v(H3,{children:[v(j1,{children:[a("h1",{children:r}),a(W3,{})]}),v(j1,{children:[v("h2",{children:[n?"Online":"Offline"," agora"]}),a(U3,{isOnline:n})]})]})]})}),a("div",{style:{position:"absolute",right:"0",bottom:"0"},children:l&&a(nf,{onClick:o})})]})}const Y3=E.div`
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  width: 100%;
  background: ${({background:e})=>e};
  border: 0.01vh solid ${({border:e})=>e};
  border-radius: 0.5vw;
  background: ${({background:e})=>e};
  color: white;
  font-size: 1.5vh;

  &:hover {
    cursor: pointer;
  }
`;function D1({children:e,...t}){return a(Y3,{...t,children:e})}const K3=E.div`
  position: absolute;
  width: 100vw;
  height: 100vh;
  background: rgba(0, 0, 0, 0.6);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999;
`,Z3=E.div`
  width: 100%;
  display: flex;
  justify-content: space-evenly;
  align-items: end;
`,X3=E.div`
  width: ${({size:e})=>e?typeof e=="number"?`${e}px`:e:"100%"};
  height: ${({size:e})=>e?typeof e=="number"?`${e}px`:"10vh":"100%"};
  border-radius:
    ${({size:e})=>e&&(typeof e=="number"?"100%":"10px")};

  display: flex;
  justify-content: center;
  align-items: ${({size:e})=>e&&typeof e=="number"?"flex-end":"center"};
  padding: 10px 0px;
  color: rgba(255, 255, 255, 0.2);

  background: ${({preview:e})=>e?`url(${e})`:"rgba(255, 255, 255, 0.08)"};
  background-size: cover;
  background-position: center;
  border: 1px solid rgba(255, 255, 255, 0.12);
`,J3=E.div`
  width: 100%;
  height: 2.6rem;
  display: grid;
  grid-gap: 1rem;
  grid-template-columns: 3fr 2fr;
`;function q3({isOpen:e,onClose:t,children:n}){return e?a(K3,{onClick:t,children:a(un,{onClick:r=>r.stopPropagation(),children:n})}):null}function em({isOpen:e,closeOverlayHandler:t,background:n,confirmOverlayHandler:r}){let i=[];switch(n){case!0:i=[{size:"100%",text:"1244x168"}];break;default:i=[{size:130,text:"130x130"},{size:100,text:"100x100"},{size:70,text:"70x70"}];break}const[o,l]=x.exports.useState("");return x.exports.useEffect(()=>{l("")},[e]),M2.createPortal(a(q3,{isOpen:e,onClose:t,children:v("div",{style:{width:"100%",height:"100%",display:"flex",flexDirection:"column",gap:"2vh",padding:"1.75vh 0.25vw"},children:[v(tu,{style:{width:"max-content"},children:["Adicionar ",n?"background":"foto de perfil"]}),a(Z3,{children:i.map((s,u)=>a(X3,{size:s.size,preview:o,children:o===""&&s.text},u))}),a(ol,{icon:a(X4,{}),handleChange:s=>l(s.target.value),placeholder:"Cole o link da imagem aqui..."}),v(J3,{children:[a(D1,{border:"#F20A45",background:"rgba(242,10,69, 0.31)",onClick:()=>{o.length>0?r(o):t()},children:"Confirmar"}),a(D1,{border:"#C62B2B",background:"rgba(198, 43, 43, 0.65)",onClick:t,children:"Fechar"})]})]})}),document.getElementById("overlay"))}function tm(){const{profile:e,selfProfile:t,setSelfProfile:n,refreshProfileWithNewData:r}=ru(),[i,o]=x.exports.useState(e),[l,s]=x.exports.useState(!1),[u,c]=x.exports.useState(!0),[p,g]=x.exports.useState(!1),m=()=>{s(!1)},C=()=>{s(!0),g(!0)},y=()=>{s(!0),g(!1)},w=async d=>{const h=parseInt(d.target.value),k=isNaN(h);c(k);const z=await r(h);o(z)},P=async()=>{const d=await r();o(d),n(d)},f=async d=>{const h=t.data;p?(h.backgroundUrl=d,We("updateBackground",d)):(h.avatarUrl=d,We("updateAvatar",d)),n({...t,data:h}),s(!1)};return x.exports.useEffect(()=>{P()},[]),v(pr,{children:[a(em,{isOpen:l,closeOverlayHandler:m,confirmOverlayHandler:f,background:p}),v(fr,{text:"meu perfil",children:[u&&a(il,{onClick:P,style:{marginRight:"0.5vw"}}),a(ol,{placeholder:"Pesquisar o perfil de um jogador",onChange:w})]}),v(un,{style:{gridArea:"2 / 2 / 3 / 3"},children:[a(Q3,{onClickEditBackgroundButton:C,onClickEditPhotoButton:y,isEditable:u,...i.data}),a(Qa,{style:{marginTop:"7.5vh"},children:v("table",{children:[a("thead",{children:v("tr",{children:[a("th",{children:a("div",{className:"rev",children:"Modos De Jogo"})}),a("th",{children:a("div",{className:"rev",children:"Posi\xE7\xE3o"})}),a("th",{children:a("div",{className:"rev",children:"Rank"})}),a("th",{children:v("div",{className:"rev",children:[a(qd,{}),"Matou"]})}),a("th",{children:v("div",{className:"rev",children:[a(Jd,{}),"Morreu"]})}),a("th",{children:v("div",{className:"rev",children:[a(Xd,{}),"Vit\xF3rias"]})}),a("th",{children:v("div",{className:"rev",children:[a(Zd,{}),"Derrotas"]})})]})}),a("tbody",{children:i.ranks.map((d,h)=>v("tr",{children:[a("td",{children:d.gamemode}),v("td",{children:[d.position,"\xBA"]}),a("td",{children:a(Qe,{rank:d.rank})}),a("td",{children:d.kills}),a("td",{children:d.deaths}),a("td",{children:d.wins}),a("td",{children:d.losses})]},h))})]})})]})]})}const nm=E.div`
  display: flex;
  flex-direction: column;
  gap: 1vh;
  width: 100%;
  height: 100%;
`,rm=E.div`
  width: 100%;
  height: 30vh;

  padding-right: 0.5vw;

  overflow-y: auto;
`,im=E.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  height: 3.25vw;
  background: ${({isWinner:e})=>e?"linear-gradient(270deg, rgba(0, 255, 85, 0.14) 0%, rgba(33, 255, 107, 0.15) 93.15%)":"linear-gradient(270deg, rgba(225, 28, 28, 0.14) 0%, rgba(198, 43, 43, 0.15) 93.15%)"};
  border-bottom: 1px solid
    ${({isWinner:e})=>e?"rgba(0, 255, 85, 1)":"rgba(225, 28, 28, 1)"};
  border-radius: 0.75vw;
  padding: 0 1vw;

  margin-bottom: 0.5vw;
`,B1=E.div`
  display: flex;
  align-items: center;
  gap: 0.75vw;
`,H1=E.span`
  font-family: 'Poppins';
  font-weight: 500;
  font-size: 0.8vw;
  line-height: 0.8vw;
  font-weight: 500;
  color: #ffffff;
  display: flex;
  align-items: center;
`,Bl=E.span`
  font-family: 'Poppins';
  font-weight: 500;
  font-size: 0.875vw;
  font-size: 0.875vw;
  color: #ffffff;
  display: flex;
  align-items: center;
  gap: 0.5vw;
`,U1=E.div`
  width: 0.15vw;
  height: 0.85vw;

  background: rgba(255, 255, 255, 0.07);
  border-radius: 17px;
`,om=E.div`
  width: 1.8vw;
  height: 1.8vw;
  
  position: relative;

  display: flex;
  align-items: center;
  justify-content: center;
`,lm=E.div`
  height: 0.65vw;
  width: 0.65vw;

  position: absolute;
  right: 0;
  bottom: 0;

  background: ${({isWinner:e})=>e?"#01BD40":"#E42121"};
  border-radius: 100%;

  display: flex;
  align-items: center;
  justify-content: center;
`;function am(e){return Ie({tag:"svg",attr:{viewBox:"0 0 512 512"},child:[{tag:"path",attr:{fill:"none",strokeLinecap:"round",strokeLinejoin:"round",strokeWidth:"32",d:"M112 160l-64 64 64 64"}},{tag:"path",attr:{fill:"none",strokeLinecap:"round",strokeLinejoin:"round",strokeWidth:"32",d:"M64 224h294c58.76 0 106 49.33 106 108v20"}}]})(e)}function rf(e){return Ie({tag:"svg",attr:{viewBox:"0 0 512 512"},child:[{tag:"path",attr:{fill:"none",strokeLinecap:"round",strokeMiterlimit:"10",strokeWidth:"32",d:"M448 225.64v99a64 64 0 01-40.23 59.42l-23.68 9.47A32 32 0 00364.6 417l-10 50.14A16 16 0 01338.88 480H173.12a16 16 0 01-15.69-12.86L147.4 417a32 32 0 00-19.49-23.44l-23.68-9.47A64 64 0 0164 324.67V224c0-105.92 85.77-191.81 191.65-192S448 119.85 448 225.64z"}},{tag:"circle",attr:{cx:"168",cy:"280",r:"40",fill:"none",strokeLinecap:"round",strokeMiterlimit:"10",strokeWidth:"32"}},{tag:"circle",attr:{cx:"344",cy:"280",r:"40",fill:"none",strokeLinecap:"round",strokeMiterlimit:"10",strokeWidth:"32"}},{tag:"path",attr:{fill:"none",strokeLinecap:"round",strokeLinejoin:"round",strokeWidth:"32",d:"M256 336l-16 48h32l-16-48zm0 112v32m-48-32v32m96-32v32"}}]})(e)}function sm(e){return Ie({tag:"svg",attr:{viewBox:"0 0 24 24"},child:[{tag:"circle",attr:{cx:"12",cy:"12",r:"3"}},{tag:"path",attr:{d:"M13 4.069V2h-2v2.069A8.008 8.008 0 0 0 4.069 11H2v2h2.069A8.007 8.007 0 0 0 11 19.931V22h2v-2.069A8.007 8.007 0 0 0 19.931 13H22v-2h-2.069A8.008 8.008 0 0 0 13 4.069zM12 18c-3.309 0-6-2.691-6-6s2.691-6 6-6 6 2.691 6 6-2.691 6-6 6z"}}]})(e)}var Lr=(e=>(e[e.bronze=0]="bronze",e[e.silver=1]="silver",e[e.gold=2]="gold",e[e.platinum=3]="platinum",e[e.diamond=4]="diamond",e[e.master=5]="master",e[e.immortal=6]="immortal",e))(Lr||{});function um(e){return Ie({tag:"svg",attr:{viewBox:"0 0 24 24"},child:[{tag:"path",attr:{fill:"none",d:"M0 0h24v24H0z"}},{tag:"path",attr:{d:"M8 5v14l11-7z"}}]})(e)}function cm(e){return Ie({tag:"svg",attr:{viewBox:"0 0 24 24"},child:[{tag:"path",attr:{fill:"none",d:"M0 0h24v24H0V0z"}},{tag:"path",attr:{d:"M7.41 8.59L12 13.17l4.59-4.58L18 10l-6 6-6-6 1.41-1.41z"}}]})(e)}function dm(e){return Ie({tag:"svg",attr:{viewBox:"0 0 24 24"},child:[{tag:"path",attr:{fill:"none",d:"M0 0h24v24H0V0z"}},{tag:"path",attr:{d:"M7.41 15.41L12 10.83l4.59 4.58L18 14l-6-6-6 6 1.41 1.41z"}}]})(e)}function Tn({points:e,enemyTeam:t,selfTeam:n,deaths:r,kills:i,rank:o}){const l=n.score>t.score,s=Lr[o.last]<Lr[o.current],u=Lr[o.last]===Lr[o.current];return v(im,{isWinner:l,children:[v(B1,{children:[v(om,{children:[a(Qe,{rank:o.current,style:{width:"100%",height:"100%"}}),!u&&a(lm,{isWinner:s,children:s?a(dm,{}):a(cm,{})})]}),v(H1,{children:[a("span",{style:{color:l?"#00FF00":"#FF0000"},children:l?"+":"-"}),e,"pts"]}),a(U1,{}),v(Bl,{children:[a("span",{style:{color:l?"#21FF6B":"#E42121"},children:l?"Vit\xF3ria":"Derrota"})," ",v("span",{style:{fontSize:"0.925vw"},children:[n.score," - ",t.score]})]})]}),v(B1,{children:[v(H1,{style:{gap:"0.5vw",textTransform:"uppercase"},children:[a(Qd,{size:16}),n.name?n.name:"Sua equipe"]}),a(U1,{}),v(Bl,{children:[a(sm,{size:16,color:"rgba(255, 255, 255, 0.5)"}),i]}),v(Bl,{children:[a(rf,{size:14,color:"rgba(255, 255, 255, 0.5)"}),r]})]})]})}const fm=E.button`
  background: rgba(255, 255, 255, 0.04);
  padding: 0.4vw 0.8vw;
  border-radius: 8px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 10px;
  font-size: 0.74vw;

  border: none;
  outline: none;
  color: white;
  text-decoration: none;

  transition: all 0.2s;
  &:hover {
    background: rgba(255, 255, 255, 0.08);
  }
`,pm=E.div`
  width: 100%;
  border-radius: 0.25vw;
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 1.75vh;
`,hm=E.div`
  width: 100%;
  height: 1.25vh;
  position: relative;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 100vw;
  overflow: hidden;
`,mm=E.div`
  width: 50%;
  height: 100%;
  background: #21ff6b;
  top: 0;
  left: 0;
  position: absolute;
  transition: all 0.25s ease;
  border-radius: 100vw;
`,gm=E.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  gap: 1.5vh;
`,vm=E.div`
  font-family: 'Rajdhani';
  font-style: normal;
  font-weight: 700;
  font-size: 1.8vw;
  line-height: 1vw;

  text-transform: uppercase;

  color: #ffffff;
`,V1=E.div`
  display: flex;
  width: 100%;
  justify-content: space-between;
  align-items: center;
  gap: 10px;
`,ym=E.div`
  display: flex;
  width: 35%;
  height: 100%;
  flex-direction: column;
  align-items: center;
  gap: 0.5vh;
  margin-top: -1.25vh;
`,W1=E.div`
  font-family: 'Poppins';
  font-weight: 500;
  font-size: 0.75vw;

  display: flex;
  align-items: center;

  color: rgba(255, 255, 255, 0.5);

  span {
    color: #fff;
  }
`;function of({children:e,returnable:t}){return v(pr,{children:[a(fr,{text:"PROGRESS\xC3O DE RANK",children:!t&&v(fm,{as:bn,to:"Preview",children:[a(G4,{color:"#F20A45"}),"Ver todos os ranks"]})}),v(un,{style:{gridArea:"2 / 2 / 3 / 3",display:"flex",flexDirection:"column",position:"relative",gap:"2vh"},children:[v(pm,{children:[v(gm,{children:[a(Qe,{rank:"bronze",style:{width:"8vw",height:"8vw"}}),a(vm,{style:{color:Kd("bronze")},children:Yd("bronze")})]}),v(ym,{children:[v(V1,{children:[a(Qe,{rank:"bronze",style:{width:"1.75vw",height:"1.75vw"}}),a(Qe,{rank:"gold",style:{width:"1.75vw",height:"1.75vw"}})]}),a(hm,{children:a(mm,{})}),v(V1,{children:[a(W1,{children:"Progresso atual"}),v(W1,{children:[a("span",{children:"1875"}),"/2000 pts"]})]})]})]}),e]})]})}const lf=E.div`
  display: flex;
  flex-direction: column;

  gap: 1vh;
`,af=E.div`
  font-family: 'Poppins';
  font-weight: 500;
  font-size: 1.1vw;
  line-height: 1.1vw;

  color: #ffffff;
`,sf=E.div`
  font-family: 'Poppins';
  font-weight: 500;
  font-size: 0.7vw;
  line-height: 0.7vw;

  color: rgba(255, 255, 255, 0.3);
`;function wm(){return a(of,{children:v(nm,{children:[v(lf,{children:[a(af,{children:"Hist\xF3rico"}),a(sf,{children:"Verifique as \xFAltimas 8 partidas jogadas"})]}),v(rm,{children:[a(Tn,{deaths:5,enemyTeam:{score:10,name:"Team 2"},kills:10,points:100,rank:{current:"bronze",last:"diamond"},selfTeam:{score:0,name:"Team 1"}}),a(Tn,{deaths:5,enemyTeam:{score:10,name:"Team 2"},kills:10,points:100,rank:{current:"diamond",last:"bronze"},selfTeam:{score:100,name:"Team 1"}}),a(Tn,{deaths:5,enemyTeam:{score:10,name:"Team 2"},kills:10,points:100,rank:{current:"bronze",last:"bronze"},selfTeam:{score:10,name:"Team 1"}}),a(Tn,{deaths:5,enemyTeam:{score:10,name:"Team 2"},kills:10,points:100,rank:{current:"bronze",last:"bronze"},selfTeam:{score:10,name:"Team 1"}}),a(Tn,{deaths:5,enemyTeam:{score:10,name:"Team 2"},kills:10,points:100,rank:{current:"bronze",last:"bronze"},selfTeam:{score:10,name:"Team 1"}}),a(Tn,{deaths:5,enemyTeam:{score:10,name:"Team 2"},kills:10,points:100,rank:{current:"bronze",last:"bronze"},selfTeam:{score:10,name:"Team 1"}})]})]})})}const xm=E.div`
  display: flex;
  flex-direction: column;
  gap: 1vh;
  width: 100%;
  height: 100%;
`,Cm=E.div`
  display: flex;

  gap: 1vw;
  width: 100%;
  height: 100%;
`,G1=E.div`
  background: rgba(255, 255, 255, 0.04);
  border: 0.1vw solid rgba(255, 255, 255, 0.04);
  border-radius: 0.25vw;
  width: 65%;
  height: 100%;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
`,km=E.div`
  display: flex;
  align-items: center;
  padding: 1vw;
  gap: 1.3rem;
  width: 43%;
`,Sm=E.div`
  font-family: 'Rajdhani';
  font-style: normal;
  font-weight: 600;
  font-size: .9vw;
  line-height: 2.5vw;
  text-transform: uppercase;
`,Em=E.div`
  font-family: 'Rajdhani';
  font-style: normal;
  font-weight: 600;
  font-size: .9vw;
  line-height: 2.5vw;
  color: #C57A4C;
`,Pm=E.div`
  display: flex;
  align-items: center;
  gap: 1vw;
`,zm=E.div`
  font-family: 'Rajdhani';
  font-style: normal;
  font-weight: 700;
  font-size: 34px;
  line-height: 43px;
`,Rm=E.div`
  font-family: 'Rajdhani';
  font-weight: 700;
  font-size: 1.8vw;
  color: #FF4800;
`;function Lm(){return a(of,{returnable:!0,children:v(xm,{children:[v(lf,{children:[a(af,{children:"Ranks"}),a(sf,{children:"Verifique o MMR necess\xE1rio para cada rank"})]}),v(Cm,{children:[a(G1,{children:["bronze","silver","gold","platinum","diamond","immortal"].map(e=>v(km,{children:[a(Qe,{rank:e,style:{height:"2.6vw",width:"2.6vw"}}),v(Pm,{children:[a(Sm,{children:e}),a(Em,{children:"0 - 999"})]})]},e))}),v(G1,{style:{display:"flex",flexDirection:"column",justifyContent:"center",alignItems:"center",width:"60%"},children:[a(Qe,{rank:"immortal",style:{height:"8vw",width:"8vw",marginBottom:".3vw"}}),a(zm,{children:"IMORTAL"}),a(Rm,{children:"10000+ PONTOS"})]})]})]})})}const Q1=E.div`
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin: 1.5vh 0;
`;function Nm(){return a("svg",{width:"19",height:"14",viewBox:"0 0 19 14",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:a("path",{d:"M18.9575 10.6392C18.9579 10.6355 18.9579 10.6318 18.9575 10.6281L17.6596 3.93273C17.6596 3.92795 17.6596 3.92318 17.6596 3.91841C17.4593 2.81913 16.8818 1.82515 16.0275 1.10927C15.1732 0.39339 14.0962 0.000887032 12.9837 3.5211e-07H6.00668C4.89107 -0.000430362 3.81103 0.394302 2.95652 1.11477C2.10201 1.83524 1.52774 2.83531 1.33473 3.93909L0.0432079 10.6281C0.0428265 10.6318 0.0428265 10.6355 0.0432079 10.6392C-0.061917 11.2388 0.0259519 11.8565 0.294057 12.4026C0.562162 12.9486 0.996547 13.3946 1.53414 13.6758C2.07174 13.957 2.68457 14.0588 3.28364 13.9663C3.88272 13.8738 4.43686 13.5919 4.86562 13.1616L4.89333 13.1322L8.03621 9.54545H10.9661L14.1105 13.1322C14.1193 13.1425 14.1288 13.152 14.1383 13.1616C14.6726 13.6972 15.3963 13.9986 16.1512 14C16.5673 13.9997 16.9783 13.908 17.3553 13.7311C17.7323 13.5543 18.0663 13.2967 18.3336 12.9764C18.601 12.6561 18.7953 12.2809 18.903 11.8772C19.0106 11.4734 19.0289 11.0508 18.9567 10.6392H18.9575ZM7.59911 5.72727H6.96562V6.36364C6.96562 6.53241 6.89888 6.69427 6.78008 6.81361C6.66128 6.93296 6.50015 7 6.33214 7C6.16412 7 6.003 6.93296 5.88419 6.81361C5.76539 6.69427 5.69865 6.53241 5.69865 6.36364V5.72727H5.06516C4.89715 5.72727 4.73602 5.66023 4.61722 5.54089C4.49842 5.42155 4.43168 5.25968 4.43168 5.09091C4.43168 4.92214 4.49842 4.76027 4.61722 4.64093C4.73602 4.52159 4.89715 4.45455 5.06516 4.45455H5.69865V3.81818C5.69865 3.64941 5.76539 3.48755 5.88419 3.36821C6.003 3.24886 6.16412 3.18182 6.33214 3.18182C6.50015 3.18182 6.66128 3.24886 6.78008 3.36821C6.89888 3.48755 6.96562 3.64941 6.96562 3.81818V4.45455H7.59911C7.76712 4.45455 7.92825 4.52159 8.04705 4.64093C8.16585 4.76027 8.23259 4.92214 8.23259 5.09091C8.23259 5.25968 8.16585 5.42155 8.04705 5.54089C7.92825 5.66023 7.76712 5.72727 7.59911 5.72727ZM10.7665 5.09091C10.7665 4.92214 10.8333 4.76027 10.9521 4.64093C11.0709 4.52159 11.232 4.45455 11.4 4.45455H13.3005C13.4685 4.45455 13.6296 4.52159 13.7484 4.64093C13.8672 4.76027 13.934 4.92214 13.934 5.09091C13.934 5.25968 13.8672 5.42155 13.7484 5.54089C13.6296 5.66023 13.4685 5.72727 13.3005 5.72727H11.4C11.232 5.72727 11.0709 5.66023 10.9521 5.54089C10.8333 5.42155 10.7665 5.25968 10.7665 5.09091ZM17.4474 12.0487C17.3288 12.2204 17.1774 12.3666 17.002 12.479C16.8267 12.5914 16.6309 12.6676 16.4259 12.7034C16.178 12.747 15.9234 12.7308 15.6829 12.6563C15.4424 12.5817 15.2229 12.451 15.0426 12.2747L12.6512 9.54545H12.9837C13.7925 9.54556 14.5879 9.33828 15.2946 8.94322C16.0014 8.54817 16.596 7.97842 17.0222 7.28795L17.7143 10.8675C17.7495 11.0723 17.7441 11.2822 17.6983 11.4849C17.6525 11.6876 17.5672 11.8793 17.4474 12.0487Z",fill:"#F20A45"})})}function Tm(){return a("svg",{width:"17",height:"16",viewBox:"0 0 17 16",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:a("path",{d:"M16.9128 15.68C16.8554 15.7773 16.7728 15.8581 16.6734 15.9143C16.574 15.9705 16.4612 16 16.3464 16H0.653212C0.538488 15.9999 0.425815 15.9702 0.326506 15.914C0.227196 15.8578 0.144747 15.777 0.087436 15.6798C0.0301252 15.5825 -2.94314e-05 15.4722 2.1555e-08 15.3599C2.94745e-05 15.2477 0.0302419 15.1374 0.0876037 15.0401C1.33243 12.934 3.25076 11.4238 5.48949 10.7079C4.38211 10.0628 3.52175 9.07972 3.04052 7.90974C2.5593 6.73975 2.48382 5.44752 2.82569 4.23149C3.16755 3.01546 3.90784 1.94287 4.93289 1.17844C5.95794 0.414005 7.21105 0 8.49979 0C9.78854 0 11.0417 0.414005 12.0667 1.17844C13.0917 1.94287 13.832 3.01546 14.1739 4.23149C14.5158 5.44752 14.4403 6.73975 13.9591 7.90974C13.4778 9.07972 12.6175 10.0628 11.5101 10.7079C13.7488 11.4238 15.6672 12.934 16.912 15.0401C16.9695 15.1373 16.9999 15.2477 17 15.36C17.0001 15.4723 16.9701 15.5827 16.9128 15.68Z",fill:"#F20A45"})})}function Y1(){return a("thead",{children:v("tr",{children:[a("th",{children:a("div",{className:"rev",children:a(p3,{style:{height:"1.25vh",width:"1.25vh"}})})}),a("th",{children:a("div",{className:"rev",children:"ID"})}),a("th",{children:a("div",{className:"rev",children:"Nome do jogador"})}),a("th",{children:a("div",{className:"rev",children:"Rank"})}),a("th",{children:v("div",{className:"rev",children:[a(qd,{}),"Matou"]})}),a("th",{children:v("div",{className:"rev",children:[a(Jd,{}),"Morreu"]})}),a("th",{children:v("div",{className:"rev",children:[a(Xd,{}),"Vit\xF3rias"]})}),a("th",{children:v("div",{className:"rev",children:[a(Zd,{}),"Derrotas"]})})]})})}function bm(){const{disponibleGamemodes:e,selfProfile:t,refreshGlobalRankGamemode:n,refreshGlobalWithNewData:r,searchUserRanking:i,refreshProfileWithNewData:o}=ru(),[l,s]=x.exports.useState(),[u,c]=x.exports.useState({data:[],totalPages:0}),[p,g]=x.exports.useState(!1),[m,C]=x.exports.useState(-1),[y,w]=x.exports.useState([]),[P,f]=x.exports.useState(1),[d,h]=x.exports.useState(!1),k=async H=>{const Q=t.ranks.find(me=>me.gamemode===H);Q&&s(Q),f(1);const ne=await n(H,1);c(ne)},z=()=>{g(!p)},_=H=>{if(H!==m){C(H);var Q;y.length>0?Q=y.map((ne,me)=>({...ne,isSelected:me===H})):Q=e.map(ne=>({text:ne,isSelected:ne===e[H]})),w(Q),k(Q[H].text),h(!1)}},M=async H=>{const Q=await n(y[m].text,H);c(Q),f(H)},b=async()=>{const H=await r(y[m].text);c(H),f(1),h(!1)},V=async H=>{const Q=H.target.value,ne=Q.length>0;if(h(ne),ne){const me=await i(parseInt(Q),y[m].text);me&&c({data:me,totalPages:0})}else await k(y[m].text)},I=async()=>{await _(0),await o(),y[m]&&await n(y[m].text,1)};return x.exports.useEffect(()=>{I()},[]),v(pr,{children:[v(fr,{text:"tabela de rank geral",children:[a(ol,{onChange:V,placeholder:"Pesquisar o perfil de um jogador"}),a(il,{style:{marginLeft:"0.5vw"},onClick:b})]}),v(un,{style:{gridArea:"2 / 2 / 3 / 3",display:"flex",flexDirection:"column"},children:[a(Q1,{children:a(Vd,{isOpen:p,onClick:z,options:y,text:y.length>0?y[m].text:"",type:"single",onClickOption:_,preMounter:v("div",{className:"mounter",children:[v("b",{children:[a(Nm,{}),a("span",{children:"Modo de jogo:"})]}),a("div",{className:"text",children:y.length>0?y[m].text:""})]}),style:{borderLeftWidth:p?"0.0vh":"0.1vh"}})}),a(Qa,{style:{height:"100%"},children:v("table",{children:[a(Y1,{}),a("tbody",{children:u.data.map((H,Q)=>v("tr",{children:[v("td",{children:[H.position,"\xBA"]}),a("td",{children:H.id}),a("td",{children:H.name}),a("td",{children:a(Qe,{rank:H.rank})}),a("td",{children:H.kills}),a("td",{children:H.deaths}),a("td",{children:H.wins}),a("td",{children:H.losses})]},Q))})]})}),v(Q1,{children:[v(tu,{style:{fontFamily:"Poppins",fontSize:"1.3vh",fontWeight:"normal",textTransform:"capitalize",padding:"0 0.8vw"},children:[a(Tm,{}),a("span",{style:{marginLeft:"0.5vw"},children:"Sua coloca\xE7\xE3o"})]}),!d&&a(v3,{onPageChange:M,page:P,totalPages:u.totalPages})]}),a(Qa,{children:v("table",{children:[a(Y1,{}),a("tbody",{children:l&&v("tr",{children:[v("td",{children:[l.position,"\xBA"]}),a("td",{children:t.data.id}),a("td",{children:t.data.name}),a("td",{children:a(Qe,{rank:l.rank})}),a("td",{children:l.kills}),a("td",{children:l.deaths}),a("td",{children:l.wins}),a("td",{children:l.losses})]})})]})})]})]})}const _m=E.div`
  display: flex;
  flex-direction: column;

  h1 {
    font-size: 1vw;
    color: #FFFFFF;
    display: flex;
    align-items: center;
    gap: 0.5vw;
  }
  h2 {
    font-size: 0.75vw;
    color: #FFFFFF;
    opacity: 0.3;
  }
`;function Ya({children:e,subContent:t}){return v(_m,{children:[a("h1",{children:e}),a("h2",{children:t})]})}function Mm(e){return Ie({tag:"svg",attr:{viewBox:"0 0 1024 1024"},child:[{tag:"path",attr:{d:"M512 64C264.6 64 64 264.6 64 512s200.6 448 448 448 448-200.6 448-448S759.4 64 512 64zm165.4 618.2l-66-.3L512 563.4l-99.3 118.4-66.1.3c-4.4 0-8-3.5-8-8 0-1.9.7-3.7 1.9-5.2l130.1-155L340.5 359a8.32 8.32 0 0 1-1.9-5.2c0-4.4 3.6-8 8-8l66.1.3L512 464.6l99.3-118.4 66-.3c4.4 0 8 3.5 8 8 0 1.9-.7 3.7-1.9 5.2L553.5 514l130 155c1.2 1.5 1.9 3.3 1.9 5.2 0 4.4-3.6 8-8 8z"}}]})(e)}function Om(e){return Ie({tag:"svg",attr:{viewBox:"0 0 1024 1024"},child:[{tag:"path",attr:{d:"M512 64C264.6 64 64 264.6 64 512s200.6 448 448 448 448-200.6 448-448S759.4 64 512 64zm192 472c0 4.4-3.6 8-8 8H544v152c0 4.4-3.6 8-8 8h-48c-4.4 0-8-3.6-8-8V544H328c-4.4 0-8-3.6-8-8v-48c0-4.4 3.6-8 8-8h152V328c0-4.4 3.6-8 8-8h48c4.4 0 8 3.6 8 8v152h152c4.4 0 8 3.6 8 8v48z"}}]})(e)}function Am(e){return Ie({tag:"svg",attr:{viewBox:"0 0 1024 1024"},child:[{tag:"path",attr:{d:"M885 780H165c-4.4 0-8 3.6-8 8v60c0 4.4 3.6 8 8 8h720c4.4 0 8-3.6 8-8v-60c0-4.4-3.6-8-8-8zM400 325.7h73.9V664c0 4.4 3.6 8 8 8h60c4.4 0 8-3.6 8-8V325.7H624c6.7 0 10.4-7.7 6.3-12.9L518.3 171a8 8 0 0 0-12.6 0l-112 141.7c-4.1 5.3-.4 13 6.3 13z"}}]})(e)}const $m=E(nu)`
  display: flex;
  justify-content: space-between;

  &:hover {
    opacity: 0.8;
  }
`,Im=E.button`
  border: none;
  outline: none;

  width: 1.5vw;
  height: 1.25vw;

  background: #AB2121;
  border-radius: 0.35vw;
  color: white;
  font-size: 0.8vw;
  line-height: 0.8vw;
  display: flex;
  justify-content: center;
  align-items: center;
`,Fm=E.div`
  display: flex;
  align-items: center;
  width: 100%;

  gap: 0.5vw;

  img {
    width: 1.25vw;
    height: 1.25vw;
    border-radius: 200vw;
  }
`;function jm({avatar:e,name:t,onClick:n,canManage:r}){return v($m,{as:"div",children:[v(Fm,{children:[a("img",{src:e}),t]}),r&&a(Im,{onClick:n,children:a(Mm,{})})]})}const uf=E.div`
  display: flex;
  align-items: center;
  padding: 0vh 0.5vw 0vh 1vw;

  background: rgba(255, 255, 255, 0.04);
  border-radius: 0.5vw;
`;E(uf)`
  justify-content: center;
  height: 6vh;

  font-size: 0.9vw;
  line-height: 0.9vw;
  font-family: 'Rajdhani';
  font-style: normal;
  font-weight: 600;

  white-space: nowrap;
`;const Dm=E.div`
  font-size: 0.8vw;
  color: #ffffff;
  text-transform: uppercase;
  font-weight: 600;

  width: 100%;
`,Bm=E.div`
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 0.5vw;
`,Hm=E.div`
  display: flex;
  align-items: center;
  position: relative;
  gap: 0.5vw;
  font-size: 0.725vw;
  color: rgba(255, 255, 255, 0.5);
  background: rgba(255, 255, 255, 0.02);
  height: 100%;
  padding: 1.5vh 1.25vw;

  span {
    font-size: 0.725vw;
    color: #ffffff;
    font-weight: 600;
  }
`,iu=E.button`
  display: flex;
  align-items: center;
  justify-content: center;
  width: auto;
  white-space: nowrap;

  border-radius: 0.5vw;
  border: none;
  padding: 0.5vh 0.9vw;
  font-size: 0.625vw;
  color: #ffffff;
  font-weight: 600;
  cursor: pointer;
  gap: 0.25vw;

  ${({unactive:e})=>e&&`
      background: rgba(255, 255, 255, 0.04);
      border: 1px solid rgba(255, 255, 255, 0.04);
      cursor: not-allowed;
    `}

  transition: all 0.3s;
  ${({unactive:e})=>!e&&`
      &:hover {
        opacity: 0.8;
      }
  `}
`,Um=E(iu)`
  background: #F20A45;
`,K1=E(iu)`
  background: #ab2121;
`,Vm=E.div`
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 0.5vw;
  width: 13vw;
`;function zt({id:e,isOwner:t,name:n,players:r,max:i}){const[o,l]=x.exports.useState(!1),s=r.length>=i,u=x.exports.useRef(null);return v(uf,{children:[a(Dm,{children:n}),v(Bm,{children:[v(Hm,{onMouseEnter:()=>l(!0),onMouseLeave:()=>l(!1),ref:u,children:["Membros:"," ",v("span",{children:[r.length,"/",i]}),o&&v(Gd,{style:{width:"12.5vw",position:"absolute",left:"-2.5vw",top:"5vh"},onMouseEnter:()=>l(!0),onMouseLeave:c=>{var p,g;l((g=(p=u.current)==null?void 0:p.contains(c.relatedTarget))!=null?g:!1)},children:[a(Wd,{children:a("span",{style:{fontWeight:500,fontSize:"0.85vw"},children:"Todos Membros"})}),a(Hd,{children:a("div",{style:{marginTop:"4.1vh",padding:"1vh 0.8vw 2vh 0.8vw"},children:r.map((c,p)=>a(jm,{canManage:t,...c}))})})]})]}),t?v(Vm,{children:[s?a(iu,{unactive:!0,children:"Time cheio"}):v(Um,{children:[a(Om,{}),"Convidar"]}),v(K1,{children:[a(Q4,{}),"Excluir Time"]})]}):a(K1,{children:"Sair do Time"})]})]})}const Wm=E.div`
  font-size: 0.8vw;
  color: #ffffff;
  text-transform: uppercase;
  font-weight: 600;
`,Gm=E.div`
  display: flex;
  align-items: center;
  justify-content: flex-end;

  height: 100%;
  border-top-right-radius: 0.5vw;
  border-bottom-right-radius: 0.5vw;

  padding: 0 0.5vw;
`,Qm=E.div`
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 6vh;
  padding-left: 1vw;
  margin-bottom: 0.75vh;

  border-radius: 0.5vw;
  background: rgba(255, 255, 255, 0.04);

  hr {
    border: 0;
    height: 1.35vh;
    width: 0.2vw;
    background: rgba(255, 255, 255, 0.15);
    border-radius: 2vw;
  }
  
  span {
    position: relative;
    font-size: 0.9vw;
    line-height: 0.9vw;
    font-family: 'Rajdhani';
    font-style: normal;
    font-weight: 600;

    white-space: nowrap;

    display: flex;
    align-items: center;
    justify-content: center;
  }
`,Z1=E.div`
  display: flex;
  align-items: center;
  justify-content: flex-start;
  flex-direction: row;
  gap: 1vw;
  height: 100%;
  width: 100%;
`,Ym=E.div`
  display: flex;
  align-items: center;
  justify-content: center;

  &, span {
    font-size: 0.9vw;
    line-height: 0.9vw;
    font-family: 'Rajdhani';
    font-style: normal;
    font-weight: 600;
  }

  .opacity {
    color: rgba(255, 255, 255, 0.5);
    margin-right: 0.25vw;
  }

  .green {
    color: #21FF6B;
    margin-left: 0.25vw;
  }

  .ball {
    width: 0.25vw;
    height: 0.25vw;
    border-radius: 200vw;
    background: #21FF6B;
    margin-left: 0.25vw;
  }
`,Km=E(fi)`
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  
  font-size: 0.75vw;
  line-height: 0.75vw;

  font-family: 'Inter';
  font-style: normal;
  font-weight: 600;

  padding: 0.5vw 0.8vw 0.5vw 1.25vw;
`;function Zm({name:e,players:t,max:n,rank:r,points:i}){return v(Qm,{children:[v(Z1,{style:{background:f3(r)},children:[v(Z1,{children:[a(Wm,{children:e}),a("hr",{}),v(Ym,{children:[t.length,v("span",{className:"opacity",children:["/",n]})," Jogadores ",a("span",{className:"green",children:"online"})," ",a("div",{className:"ball"})]})]}),v("span",{style:{gap:"0.5vw",marginRight:"0.5vw"},children:[a("span",{style:{color:Kd(r)},children:Yd(r).toUpperCase()})," ",i,"pts ",a(Qe,{rank:r})]})]}),a(Gm,{children:v(Km,{children:["JOGAR ",a(um,{})]})})]})}const X1=E.div`
  display: flex;
  flex-direction: column;
  gap: 0.5vw;
  height: 100%;

  overflow-y: scroll;
  padding-right: 0.5vw;
  margin-top: 0.5vw;
`;function Xm(){return v(pr,{children:[a(fr,{text:"todos os times"}),v(un,{style:{gridArea:"2 / 2 / 3 / 3",display:"flex",flexDirection:"column",padding:"1vw"},children:[v(Ya,{subContent:"Veja os times que voc\xEA \xE9 dono",children:["Meus times ",a(W4,{color:"#F20A45"})]}),v(X1,{children:[a(zt,{id:1,isOwner:!0,max:10,players:[{avatar:"https://i.imgur.com/0y8Ftya.png",name:"Jogador 1",id:1},{avatar:"https://i.imgur.com/0y8Ftya.png",name:"Jogador 2",id:2}],name:"NOME TIME",points:100,rank:"bronze"}),a(zt,{id:1,isOwner:!0,max:0,players:[],name:"NOME TIME",points:100,rank:"bronze"})]}),a(Ya,{subContent:"Times que voc\xEA faz parte",children:"Outros times"}),v(X1,{children:[a(zt,{id:1,max:10,players:[{avatar:"https://i.imgur.com/0y8Ftya.png",name:"Jogador 1",id:1},{avatar:"https://i.imgur.com/0y8Ftya.png",name:"Jogador 2",id:2}],name:"NOME TIME",points:100,rank:"bronze"}),a(zt,{id:1,max:10,players:[],name:"NOME TIME",points:100,rank:"bronze"}),a(zt,{id:1,max:10,players:[],name:"NOME TIME",points:100,rank:"bronze"}),a(zt,{id:1,max:10,players:[],name:"NOME TIME",points:100,rank:"bronze"}),a(zt,{id:1,max:10,players:[],name:"NOME TIME",points:100,rank:"bronze"}),a(zt,{id:1,max:10,players:[],name:"NOME TIME",points:100,rank:"bronze"}),a(zt,{id:1,max:10,players:[],name:"NOME TIME",points:100,rank:"bronze"})]})]})]})}const Jm=E.div`
  display: flex;
  align-items: center;
  flex-direction: row;
  gap: 0.5vw;

`,qm=E(fi)`
  justify-content: center;
  color: #FFFFFF;

  height: 2vw;
  width: 2vw;
`,e6=E.ul`
  height: 100%;

  overflow-y: auto;
  padding-right: 0.75vw;
`;function t6(){let{uuid:e}=Mh();const t=di(),[n,r]=x.exports.useState([]),[i,o]=x.exports.useState([]),l=u=>{const c=u.target.value;if(c.length>0){const g=n.filter(m=>m.name.toLowerCase().includes(c.toLowerCase()));o(g)}else o(n)},s=()=>{We("getDisponibleTeams",{uuid:e},[{id:1,max:5,name:"Time 1",players:[],rank:"bronze",points:0},{id:1,max:5,name:"Time 2",players:[],rank:"bronze",points:0},{id:1,max:5,name:"Time 3",players:[],rank:"bronze",points:0},{id:1,max:5,name:"Time 4",players:[],rank:"bronze",points:0},{id:1,max:5,name:"Time 5",players:[],rank:"bronze",points:0},{id:1,max:5,name:"Time 6",players:[],rank:"bronze",points:0},{id:1,max:5,name:"Time 7",players:[],rank:"bronze",points:0},{id:1,max:5,name:"Time 6",players:[],rank:"bronze",points:0},{id:1,max:5,name:"Time 7",players:[],rank:"bronze",points:0},{id:1,max:5,name:"Time 6",players:[],rank:"bronze",points:0},{id:1,max:5,name:"Time 7",players:[],rank:"bronze",points:0},{id:1,max:5,name:"Time 6",players:[],rank:"bronze",points:0},{id:1,max:5,name:"Time 7",players:[],rank:"bronze",points:0}]).then(u=>{r(u),o(u)})};return x.exports.useEffect(()=>{s()},[]),v(pr,{children:[v(fr,{text:"modos de jogo",children:[a(ol,{placeholder:"Pesquisar por um time...",onChange:l}),a(il,{onClick:s,style:{marginLeft:"0.5vw"}})]}),v(un,{style:{gridArea:"2 / 2 / 3 / 3",display:"flex",flexDirection:"column",padding:"1vw",gap:"1vh",height:"100%"},children:[v(Jm,{children:[a(qm,{onClick:()=>{t(-1)},children:a(am,{})}),a(Ya,{subContent:"Todos os times dispon\xEDveis para jogar",children:"Times"})]}),a(e6,{children:i.map((u,c)=>a(Zm,{...u},c))})]})]})}const n6=E.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 40%;
  height: max-content;
  padding: 20px;

  box-sizing: border-box;
  background: rgba(0, 0, 0, 0.5);
  border: 1px solid #F20A45;
  border-radius: 15px;
`,r6=E.div`
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 15px;
`,i6=E.table`
  width: 100%;
  border-collapse: collapse;
  background: rgba(255, 255, 255, 0.04);
  border-radius: 15px;
  overflow: hidden;

  thead {
    background: rgba(255, 255, 255, 0.04);
    border-radius: 10px;

    tr, th {
      font-family: 'Poppins';
      font-style: normal;
      font-weight: 700;
      font-size: .8rem;
      line-height: 24px;
      color: rgba(255, 255, 255, 0.5);
    }
  }

  th, td {
    padding: 5px;
    text-align: center;
  }

  tr, td {
    font-size: .9rem;

    .positive {
      color: #00FF55;
    }
    .negative {
      color: #FF4545;
    }
  }

  .winner {
    background:  rgba(1, 189, 64, 0.3);
  }

  .winner:nth-child(even) {
    background: rgba(1, 189, 64, 0.15);
  }

  .lose {
    background:  rgba(255, 69, 69, 0.2);
  }

  .lose:nth-child(even) {
    background:  rgba(255, 69, 69, 0.1);
  }
`,J1=E.div`
  margin-top: 18px;
`,Hl=E.div`
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
`,o6=E.div`
  font-family: 'Poppins';
  font-style: normal;
  font-weight: 700;
  font-size: 46px;

  display: flex;
  align-items: center;
  text-align: center;

  color: #00FF55;
`,l6=E.div`
  font-family: 'Poppins';
  font-style: normal;
  font-weight: 700;
  font-size: 46px;

  display: flex;
  align-items: center;
  text-align: center;

  color: #FF4545;
`,a6=E.div`
  font-family: 'Poppins';
  font-style: normal;
  font-weight: 700;
  font-size: 38px;
  margin-right: 20px;
  margin-left: 20px;

  display: flex;
  align-items: center;
  text-align: center;

  color: #FFFFFF;

  position: relative;

  &::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 20%;
    right: 20%;
    width: 65%;
    height: .1rem;
    background: #00FF55;
    border-radius: 0px 0px 1.5px 1.5px;
  }
`,s6=E.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 40%;
  gap: 10px;
  margin-top: 15px;
`,q1=E.div`
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;

  span {
    font-family: 'Poppins';
    font-style: normal;
    font-weight: 500;
    font-size: 12px;
    color: rgba(255, 255, 255, 0.5);
  }
`,u6=E.div`
  width: 100%;
  height: 0.8rem;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 15px;

  position: relative;

  &::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 25%;
    height: 100%;
    background: rgba(33, 255, 107, 0.5);
    border-radius: 15px;
    overflow: hidden;
    z-index: 1;
  }
`,c6=E.div`
  width: 20%;
  height: 100%;
  background: rgba(33, 255, 107, 1);
  border-radius: 15px;
  position: absolute;
  left: 0;
  top: 0;
  z-index: 2;
`,d6=E.div`
  font-family: 'Poppins';
  font-style: normal;
  font-weight: 500;
  font-size: 12px;
  color: #FFFFFF;
  position: absolute;
  right: 0;
  top: -1.4rem;
  z-index: 3;
`;function f6(e){return Ie({tag:"svg",attr:{viewBox:"0 0 1024 1024"},child:[{tag:"path",attr:{d:"M944 224c-44.192 0-79.999 35.824-79.999 80 0 9.072 1.84 17.632 4.607 25.76L673.6 497.68C659.92 486.784 642.848 480 624 480c-21.743 0-41.407 8.736-55.808 22.816l-152.752-76.48C412.465 384.848 378.241 352 336 352c-44.175 0-80 35.824-80 80 0 12.096 2.88 23.44 7.68 33.712L107.936 645.296C99.2 642.032 89.872 640 80 640c-44.176 0-80 35.824-80 80s35.824 80 80 80 80-35.824 80-80c0-10.64-2.176-20.767-5.952-30.048l158.272-181.92C319.856 510.368 327.696 512 336 512c23.28 0 44.047-10.112 58.671-26l149.408 74.912C544.608 604.656 580.127 640 624 640c44.193 0 80-35.824 80-80 0-1.424-.336-2.752-.416-4.16L911.68 377.072C921.584 381.456 932.463 384 944 384c44.193 0 80-35.808 80-80 0-44.176-35.807-80-79.999-80z"}}]})(e)}const p6=E.div`
  width: 100%;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
`;function h6(){return v(p6,{children:[v(r6,{children:[a(o6,{children:"5 "}),a(a6,{children:"VIT\xD3RIA"}),a(l6,{children:" 8"})]}),a(n6,{children:v(i6,{children:[a("thead",{children:v("tr",{children:[a("th",{children:a(f6,{})}),a("th",{children:"NOME DO JOGADOR"}),a("th",{children:"RANK"}),a("th",{children:v(Hl,{children:[a(u4,{}),"MATOU"]})}),a("th",{children:v(Hl,{children:[a(rf,{}),"MORREU"]})}),a("th",{children:v(Hl,{children:[a(Am,{}),"PONTOS"]})})]})}),a(J1,{}),v("tbody",{children:[Array.from(Array(5).keys()).map((e,t)=>v("tr",{className:"winner",children:[v("td",{children:[t+1,"\xB0"]}),a("td",{children:"NORRIS SANTA GROUP"}),a("td",{children:a(Qe,{rank:"bronze"})}),a("td",{children:"8"}),a("td",{children:"5"}),v("td",{children:[t===1?a("span",{className:"positive",children:"+"}):a("span",{className:"negative",children:"-"}),"8"]})]},t)),a(J1,{}),Array.from(Array(5).keys()).map((e,t)=>v("tr",{className:"lose",children:[v("td",{children:[t+1,"\xB0"]}),a("td",{children:"NORRIS SANTA GROUP"}),a("td",{children:a(Qe,{rank:"bronze"})}),a("td",{children:"8"}),a("td",{children:"5"}),v("td",{children:[t===1?a("span",{className:"positive",children:"+"}):a("span",{className:"negative",children:"-"}),"8"]})]},t))]})]})}),v(s6,{children:[v(q1,{children:[a(Qe,{style:{width:"2rem",height:"2rem"},rank:"bronze"}),a(Qe,{style:{width:"2rem",height:"2rem"},rank:"silver"})]}),a(u6,{children:a(c6,{children:a(d6,{children:"+200"})})}),v(q1,{children:[a("span",{children:"Progresso atual"}),a("span",{children:"1875/2000 pts"})]})]})]})}const m6=E.div`
  background: linear-gradient(
    180deg,
    rgba(255, 184, 29, 0.12) 0%,
    rgba(255, 184, 29, 0) 100%
  );
  background-size: 100% 100%;
  height: 100vh;
  width: 100vw;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: 'Poppins', sans-serif;
  overflow: hidden;
`,g6=E.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 90rem;
  height: 50rem;
  position: relative;

  background: rgba(0, 0, 0, 0.67);

  .exit {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    position: absolute;
    right: -1%;
    top: -2%;
    background: #0c0801;
    font-size: 0.6rem;
    display: flex;
    align-items: center;
    justify-content: center;

    :hover {
      cursor: pointer;
    }
  }

  .header {
    width: 100%;
    height: 20%;
    display: flex;
    align-items: flex-end;
    justify-content: space-between;
    padding: 0 2rem;
    background: rgba(0, 0, 0, 0.46);

    &-logo {
      display: flex;
      align-items: center;
      gap: 1rem;
      height: 100%;
      padding-left: 2%;
      font-size: 1rem;

      img {
        width: 30rem;
        height: 25rem;
      }
    }

    &-categorys {
      display: flex;
      gap: 1rem;
      font-size: 0.6rem;

      &-item {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 1rem;
        cursor: pointer;
        transition: 0.2s;
        background: rgba(255, 255, 255, 0.04);

        :hover {
          opacity: 0.8;
          background: #F20A45;
          box-shadow: 0px 0px 4px rgba(255, 255, 255, 0.25);

          h1 {
            color: #0c0801;
            opacity: 1;
          }
        }
      }
    }
  }

  .lobby {
    height: 86%;
    width: 96%;

    &-arenas {
      display: flex;
      width: 100%;
      height: 100%;
      flex-wrap: wrap;
      justify-content: center;
      gap: 1rem;
      overflow: auto;
      padding: 1.6rem;

      ::-webkit-scrollbar {
        display: none;
      }

      #item {
        visibility: hidden;
      }
      &-item:hover #item {
        visibility: ${e=>e.visible?"hidden":"visible"};
      }

      &-item {
        display: flex;
        flex-direction: column;
        font-size: 0.6rem;
        width: 21%;
        height: 27%;
        opacity: 0.8;
        transition: 0.2s;

        &-header {
          background: rgba(0, 0, 0, 0.89);
          text-align: center;
        }
        &-select {
          display: flex;
          align-items: center;
          justify-content: center;
          width: 100%;
          height: 80%;
          font-size: 0.5rem;
        }
        &-footer {
          display: flex;
          align-items: baseline;
          justify-content: end;
          gap: 0.4rem;
          font-size: 1rem;
          padding-right: 1rem;
        }

        :hover {
          cursor: pointer;
          opacity: 1;
          box-shadow: 0px 0px 16px #F20A45;
        }
      }
    }
  }
`,v6=E.div`
  background: url(${e=>e.bg}) no-repeat center;
  background-size: 100% 100%;
`;function y6({size:e}){return a("svg",{xmlns:"http://www.w3.org/2000/svg",width:e,height:e,fill:"none",viewBox:"0 0 9 9",children:a("path",{fill:"#fff",d:"M4.5 0a2.25 2.25 0 110 4.5 2.25 2.25 0 010-4.5zm0 5.625c2.486 0 4.5 1.007 4.5 2.25V9H0V7.875c0-1.243 2.014-2.25 4.5-2.25z"})})}function w6(){const e=[{name:"1x1"},{name:"3x3"},{name:"6x6"}],[t,n]=Y.useState({"1x1":[],"3x3":[],"6x6":[]}),[r,i]=Y.useState("1x1");we("Arenas",u=>{n({"1x1":u.filter(c=>c.category==="1x1"),"3x3":u.filter(c=>c.category==="3x3"),"6x6":u.filter(c=>c.category==="6x6")})});const o=(u,c)=>{We("PlayerClickAction",{action:u,id:c})},[l,s]=Y.useState(!0);return x.exports.useEffect(()=>{const u=c=>{c.key==="Escape"&&s(!l)};return window.addEventListener("keydown",u),()=>{window.removeEventListener("keydown",u)}},[]),a(m6,{children:v(g6,{visible:!l,children:[a("div",{onClick:()=>{We("hideFrame")},className:"exit",children:a("h1",{children:"X"})}),v("div",{className:"header",children:[a("div",{className:"header-logo"}),a("div",{className:"header-categorys",children:e.map((u,c)=>a("div",{onClick:()=>i(u.name),className:"header-categorys-item",children:v("h1",{children:["ARENA ",u.name]})},c))})]}),a("div",{className:"lobby",children:a("div",{className:"lobby-arenas",children:t[r].map((u,c)=>v(v6,{onClick:()=>{o(r,c+1),s(!1)},className:`lobby-arenas-item ${r}`,bg:`nui://arena/web-side/assets/${r}.png`,children:[a("div",{className:"lobby-arenas-item-header",children:v("h1",{children:["ARENA #",c+1]})}),a("div",{className:"lobby-arenas-item-select",id:"item",children:a("h1",{children:"SELECIONAR ARENA"})}),v("div",{className:"lobby-arenas-item-footer",children:[a(y6,{size:14}),a("span",{children:u.players})]})]}))})})]})})}const x6=E.div`
  height: 100vh;
  width: 100vw;
  padding: 2vh 1vw;
`,C6=E.div`
  flex: 1;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-end;
  text-transform: uppercase;
`,k6=E.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;

  background-color: rgba(0, 0, 0, 0.8);
  border-radius: 0.5vh;
  box-shadow: 0 0 0.5vh 0.1vh rgba(0, 0, 0, 0.5);

  padding: 1vh 1vw;

  b {
    font-weight: bold;
    color: #F20A45;
  }

  h1 {
    font-size: 1.2vh;
  }

  h2 {
    font-size: 1vh;
    margin-top: 0.1vh;
  }
`,S6=E.div`
  margin-top: 0.5vh;
  font-size: 1vh;
`;function E6(){const[e,t]=x.exports.useState("corrida armada"),[n,r]=x.exports.useState(5),[i,o]=x.exports.useState("F7");return we("updateQueueData",l=>{t(l.gamemode),r(l.remainingPlayers),o(l.buttonText||"F7")}),a(x6,{children:v(C6,{children:[v(k6,{children:[v("h1",{children:["voc\xEA est\xE1 na fila da ",a("b",{children:e})]}),v("h2",{children:[v("b",{children:["faltam ",n," jogadores"]})," para ser iniciado"]})]}),v(S6,{children:["pressione ",i," para cancelar"]})]})})}const P6=E.div`
  background-size: 100% 100%;
  height: 100vh;
  width: 100vw;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: 'Poppins', sans-serif;
  overflow: hidden;
  position: relative;
`;function z6(){const[e,t]=x.exports.useState([{name:"VERMELHOS",score:1e3},{name:"VERDES",score:999},{name:"AMARELOS",score:988},{name:"ROXOS",score:115},{name:"YAKUZA",score:19}]);return x.exports.useEffect(()=>{We("getFacRank",e)},[]),a(P6,{children:a(pf,{teams:e,style:{transform:"translateY(-50%) scale(0.75)"}})})}function R6(){return a(tl,{children:v(Wh,{children:[a(Re,{path:"/",element:a(w6,{})}),a(Re,{path:"/GunGame",element:a(z4,{})}),a(Re,{path:"/GunGameQueue",element:a(E6,{})}),a(Re,{path:"/AimLabs",element:a(r4,{})}),a(Re,{path:"/DominationProvisional",element:a(k4,{})}),a(Re,{path:"/Arena",element:a(d4,{})}),a(Re,{path:"/Score",element:a(h6,{})}),a(Re,{path:"/Lobby",element:a(Uh,{to:"/Lobby/Gamemodes"})}),a(Re,{path:"/Lobby/Gamemodes",element:a(A3,{})}),a(Re,{path:"/Lobby/Teams/Gamemodes/:uuid",element:a(t6,{})}),a(Re,{path:"/Lobby/Profile",element:a(tm,{})}),a(Re,{path:"/Lobby/Ranking",element:a(bm,{})}),a(Re,{path:"/Lobby/Ranks",element:a(wm,{})}),a(Re,{path:"/Lobby/Ranks/Preview",element:a(Lm,{})}),a(Re,{path:"/Lobby/Teams",element:a(Xm,{})}),a(Re,{path:"/fac-rank",element:a(z6,{})})]})})}E.div`
  display: flex;

  background: rgba(0, 0, 0, 0.75);
  box-shadow: 0px 0px 4px rgba(242,10,69, 0.07);

  border-radius: 8px 0px 0px 8px;

  font-size: 8px;
  overflow: hidden;

  .logo {
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(242,10,69, 0.63);

    padding: 0.6rem;
  }

  .text {
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.5rem;
    padding: 0 1rem;

    h1 {
      font-weight: 800;
    }
  }
`;const L6=E.div`
  display: flex;
  gap: 1rem;
  align-items: center;
  position: absolute;
  width: 10rem;
  height: 3rem;
  left: 0;
  top: ${e=>e.top}%;
  font-size: 1.2rem;
  font-family: 'Poppins';
  font-style: normal;
  font-weight: 600;

  border-radius: 0 20px 20px 0;

  background: rgba(0, 0, 0, 0.67);

  .shortcut {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 2rem;
    height: 100%;
    border-radius: 0 20px 20px 0;
    background: rgba(242,10,69, 0.63);
  }
`;function ii({text:e,shortcut:t,altura:n}){return v(L6,{top:n,children:[a("div",{className:"shortcut",children:a("span",{children:t})}),e]})}const N6=E.div`
  display: flex;
  align-items: center;
  gap: 0.4rem;

  @keyframes bounceY {
    0% {
      transform: scaleX(1) translateY(0);
    }
    50% {
      transform: translateY(-0.5rem);
    }
    100% {
      transform: scaleX(-1) translateY(0);
    }
  }

  @keyframes bounceX {
    0% {
      transform: scaleX(1) translateY(0);
    }
    50% {
      transform: translateY(-0.5rem);
    }
    100% {
      transform: scaleX(-1) translateY(0);
    }
  }

  .flag-scaleX {
    animation: bounceX 1.2s infinite alternate;
  }
  .flag-scaleY {
    animation: bounceY 1.2s infinite alternate;
  }

  .timer {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;

    h1 {
      font-size: 3rem;
    }
    span {
      font-size: 0.8rem;
      text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
    }
  }
`;function ec({rotate:e,size:t,scaleX:n}){return a("svg",{xmlns:"http://www.w3.org/2000/svg",width:t||50,fill:"none",viewBox:"0 0 50 50",className:n?"flag-scaleX":"flag-scaleY",style:{transform:`rotate(${e}deg)`},children:a("path",{fill:"#fff",d:"M34.756 49.537l2.1-.929a1.723 1.723 0 00.88-2.272l-1.188-2.688A21.457 21.457 0 0045.37 33.06a21.451 21.451 0 00.6-13.77l2.687-1.188a1.723 1.723 0 00.879-2.272l-.929-2.101a1.723 1.723 0 00-2.272-.879l-2.688 1.188A21.454 21.454 0 0033.06 5.215a21.45 21.45 0 00-13.77-.6l-1.188-2.687a1.723 1.723 0 00-2.272-.879l-2.101.929a1.723 1.723 0 00-.88 2.272l1.19 2.688a21.453 21.453 0 00-8.823 10.588 21.452 21.452 0 00-.6 13.77l-2.688 1.188a1.723 1.723 0 00-.879 2.272l.929 2.1a1.723 1.723 0 002.272.88l2.688-1.188a21.453 21.453 0 0010.588 8.823 21.451 21.451 0 0013.77.6l1.188 2.687a1.723 1.723 0 002.272.879zm-15.158-9.522a15.67 15.67 0 01-7.343-5.818l2.276-1.007a1.723 1.723 0 00.88-2.272l-.93-2.1a1.723 1.723 0 00-2.272-.88l-2.276 1.007a15.67 15.67 0 01.638-9.347 15.669 15.669 0 015.818-7.343l1.007 2.277a1.723 1.723 0 002.272.879l2.1-.93a1.723 1.723 0 00.88-2.271L21.64 9.933a15.67 15.67 0 019.347.638 15.67 15.67 0 017.343 5.818l-2.277 1.007a1.723 1.723 0 00-.879 2.272l.93 2.101a1.723 1.723 0 002.271.879l2.277-1.006a15.67 15.67 0 01-.638 9.346 15.67 15.67 0 01-5.818 7.343l-1.007-2.277a1.723 1.723 0 00-2.272-.879l-2.101.93a1.723 1.723 0 00-.879 2.272l1.007 2.276a15.67 15.67 0 01-9.347-.638z"})})}function tc({scaleX:e}){return a("svg",{xmlns:"http://www.w3.org/2000/svg",width:"70",height:"70",fill:"none",className:e?"flag-scaleX":"flag-scaleY",viewBox:"0 0 70 70",children:a("path",{fill:"#fff",d:"M59.862 47.465l-.889.35a1.663 1.663 0 01-2.157-.938L42.502 10.525a2.079 2.079 0 011.173-2.696l.115-.045a2.079 2.079 0 012.696 1.173L60.8 45.308a1.663 1.663 0 01-.938 2.157zM14.469 48.832a39.837 39.837 0 003.505-10.556.819.819 0 00-.319-.807A117.852 117.852 0 015.8 26.806c-.613-.638-.391-1.13.371-.95C21.058 29.29 26.217 8.001 40.694 10.408c.04.254.11.503.205.741l9.295 23.595C35.781 32.45 30.618 53.635 15.76 50.21c-.761-.18-1.502-1.002-1.29-1.378z"})})}function cf({time:e,title:t,setTime:n}){return x.exports.useEffect(()=>{const r=setInterval(()=>{n(e-1)},1e3);return()=>clearInterval(r)}),v(N6,{children:[t==="DOMINA\xC7\xC3O"?a(tc,{scaleX:!1}):a(ec,{rotate:60,scaleX:!1}),v("div",{className:"timer",children:[a("h1",{children:t}),v("span",{children:["Partida iniciando em ",e]})]}),t==="DOMINA\xC7\xC3O"?a(tc,{scaleX:!0}):a(ec,{rotate:60,scaleX:!0})]})}var T6=e=>typeof e=="function",nc=(e,t)=>T6(e)?e(t):e,b6=(()=>{let e=0;return()=>(++e).toString()})(),_6=20,Qi=new Map,M6=1e3,rc=e=>{if(Qi.has(e))return;let t=setTimeout(()=>{Qi.delete(e),Ln({type:4,toastId:e})},M6);Qi.set(e,t)},O6=e=>{let t=Qi.get(e);t&&clearTimeout(t)},Ka=(e,t)=>{switch(t.type){case 0:return{...e,toasts:[t.toast,...e.toasts].slice(0,_6)};case 1:return t.toast.id&&O6(t.toast.id),{...e,toasts:e.toasts.map(o=>o.id===t.toast.id?{...o,...t.toast}:o)};case 2:let{toast:n}=t;return e.toasts.find(o=>o.id===n.id)?Ka(e,{type:1,toast:n}):Ka(e,{type:0,toast:n});case 3:let{toastId:r}=t;return r?rc(r):e.toasts.forEach(o=>{rc(o.id)}),{...e,toasts:e.toasts.map(o=>o.id===r||r===void 0?{...o,visible:!1}:o)};case 4:return t.toastId===void 0?{...e,toasts:[]}:{...e,toasts:e.toasts.filter(o=>o.id!==t.toastId)};case 5:return{...e,pausedAt:t.time};case 6:let i=t.time-(e.pausedAt||0);return{...e,pausedAt:void 0,toasts:e.toasts.map(o=>({...o,pauseDuration:o.pauseDuration+i}))}}},Yi=[],Ki={toasts:[],pausedAt:void 0},Ln=e=>{Ki=Ka(Ki,e),Yi.forEach(t=>{t(Ki)})},A6={blank:4e3,error:4e3,success:2e3,loading:1/0,custom:4e3},$6=(e={})=>{let[t,n]=x.exports.useState(Ki);x.exports.useEffect(()=>(Yi.push(n),()=>{let i=Yi.indexOf(n);i>-1&&Yi.splice(i,1)}),[t]);let r=t.toasts.map(i=>{var o,l;return{...e,...e[i.type],...i,duration:i.duration||((o=e[i.type])==null?void 0:o.duration)||(e==null?void 0:e.duration)||A6[i.type],style:{...e.style,...(l=e[i.type])==null?void 0:l.style,...i.style}}});return{...t,toasts:r}},I6=(e,t="blank",n)=>({createdAt:Date.now(),visible:!0,type:t,ariaProps:{role:"status","aria-live":"polite"},message:e,pauseDuration:0,...n,id:(n==null?void 0:n.id)||b6()}),pi=e=>(t,n)=>{let r=I6(t,e,n);return Ln({type:2,toast:r}),r.id},qe=(e,t)=>pi("blank")(e,t);qe.error=pi("error");qe.success=pi("success");qe.loading=pi("loading");qe.custom=pi("custom");qe.dismiss=e=>{Ln({type:3,toastId:e})};qe.remove=e=>Ln({type:4,toastId:e});qe.promise=(e,t,n)=>{let r=qe.loading(t.loading,{...n,...n==null?void 0:n.loading});return e.then(i=>(qe.success(nc(t.success,i),{id:r,...n,...n==null?void 0:n.success}),i)).catch(i=>{qe.error(nc(t.error,i),{id:r,...n,...n==null?void 0:n.error})}),e};var F6=(e,t)=>{Ln({type:1,toast:{id:e,height:t}})},j6=()=>{Ln({type:5,time:Date.now()})},D6=e=>{let{toasts:t,pausedAt:n}=$6(e);x.exports.useEffect(()=>{if(n)return;let o=Date.now(),l=t.map(s=>{if(s.duration===1/0)return;let u=(s.duration||0)+s.pauseDuration-(o-s.createdAt);if(u<0){s.visible&&qe.dismiss(s.id);return}return setTimeout(()=>qe.dismiss(s.id),u)});return()=>{l.forEach(s=>s&&clearTimeout(s))}},[t,n]);let r=x.exports.useCallback(()=>{n&&Ln({type:6,time:Date.now()})},[n]),i=x.exports.useCallback((o,l)=>{let{reverseOrder:s=!1,gutter:u=8,defaultPosition:c}=l||{},p=t.filter(C=>(C.position||c)===(o.position||c)&&C.height),g=p.findIndex(C=>C.id===o.id),m=p.filter((C,y)=>y<g&&C.visible).length;return p.filter(C=>C.visible).slice(...s?[m+1]:[0,m]).reduce((C,y)=>C+(y.height||0)+u,0)},[t]);return{toasts:t,handlers:{updateHeight:F6,startPause:j6,endPause:r,calculateOffset:i}}};const B6=()=>{const{toasts:e,handlers:t}=D6(),{startPause:n,endPause:r,calculateOffset:i,updateHeight:o}=t;return a("div",{style:{position:"absolute",top:100,left:"75%"},children:e.map(l=>{const s=i(l,{reverseOrder:!1,gutter:10});return a("div",{ref:c=>{if(c&&typeof l.height!="number"){const p=c.getBoundingClientRect().height;o(l.id,p)}},style:{display:"flex",alignItems:"center",justifyContent:"space-between",gap:"2rem",padding:"8px 16px",position:"absolute",width:"295px",transition:"all 0.5s ease-out",opacity:l.visible?1:0,transform:`translateY(${s}px)`,background:"linear-gradient(0deg,rgba(0,0,0,0.5),rgba(0,0,0,0.5)),rgba(255,255,255,0.02)",border:"0.1vh solid #F20A45",borderRadius:"0.5vh"},...l.ariaProps,children:l.message},l.id)})})};function al({killfeed:e,image:t}){return x.exports.useEffect(()=>{!e||qe.custom(v(tl,{children:[a("span",{style:{color:"#ffffff",textOverflow:"ellipsis",whiteSpace:"nowrap",overflow:"hidden",width:"35%",fontSize:"0.85em",fontFamily:"Poppins",marginRight:"-32px"},children:e==null?void 0:e.killer}),a("img",{style:{objectFit:"contain",objectPosition:"center center",width:"32px",height:"100%",margin:"0 5px",clear:"both"},src:lr()?"https://www.pngplay.com/wp-content/uploads/12/Handgun-PNG-HD-Images.png":`nui://arena/web-side/assets/weapons/${t}.png`,alt:""}),a("span",{style:{color:"#ffffff",textOverflow:"ellipsis",whiteSpace:"nowrap",overflow:"hidden",width:"35%",fontSize:"0.85em",fontFamily:"Poppins",marginLeft:"-32px"},children:e==null?void 0:e.victim})]}))},[e]),a(B6,{})}const df=E.div`
  background-size: 100% 100%;
  height: 100vh;
  width: 100vw;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: 'Poppins', sans-serif;
  overflow: hidden;
  position: relative;
`,H6=E.div`
  position: relative;

  display: flex;
  align-items: flex-start;
  justify-content: flex-start;
  border-radius: 0.2vw;
  height: 1.4vh;
  width: 13vw;
  overflow: hidden;

  .bar {
    position: absolute;
    display: flex;
    height: 100%;
    border-radius: 0.2vw;
    border: 0.25vh solid;
  }
`;function U6({innerBackground:e,outerBackground:t,max:n,value:r}){return a(H6,{style:{background:e!=null?e:"rgba(0, 0, 0, 0.7)"},children:a("div",{className:"bar",style:{background:t,width:`${100*r/n}%`,borderColor:e!=null?e:"rgba(0, 0, 0, 0.7)"}})})}function V6({value:e,max:t,...n}){return a(U6,{outerBackground:"#F20A45",value:e,max:t-100,...n})}const W6=E.div`
  position: absolute;
  bottom: 3vh;
  right: 4vw;

  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  .discord {
    color: rgba(255, 255, 255, 0.9);
    margin-top: 0.5vh;
    font-weight: 500;
    font-size: 0.775vw;
    text-transform: uppercase;
    letter-spacing: 0.1vw;
  }
`;function ff({discord:e,health:t}){return v(W6,{children:[a(V6,{max:400,value:t}),a("div",{className:"discord",children:e})]})}function G6(e){return a("svg",{width:"11",height:"17",viewBox:"0 0 11 17",fill:"none",xmlns:"http://www.w3.org/2000/svg",...e,children:a("path",{d:"M9.42857 0.5H6.28571V3.7472C7.41032 3.87306 8.48848 4.27347 9.42857 4.9144V0.5ZM4.71429 0.5H1.57143V4.9144C2.51152 4.27347 3.58968 3.87306 4.71429 3.7472V0.5ZM5.5 16.5C6.95869 16.5 8.35764 15.91 9.38909 14.8598C10.4205 13.8096 11 12.3852 11 10.9C11 9.41479 10.4205 7.99041 9.38909 6.9402C8.35764 5.89 6.95869 5.3 5.5 5.3C4.04131 5.3 2.64236 5.89 1.61091 6.9402C0.579463 7.99041 0 9.41479 0 10.9C0 12.3852 0.579463 13.8096 1.61091 14.8598C2.64236 15.91 4.04131 16.5 5.5 16.5ZM4.5375 9.6848L5.5 7.7L6.4625 9.6848L8.61379 10.0024L7.05729 11.548L7.425 13.7296L5.5 12.7L3.57579 13.7296L3.9435 11.548L2.387 10.0024L4.5375 9.6848Z",fill:e.fill})})}const Q6=E.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-radius: 0.3vw;
  padding: 1.2vh 1.1vw;
  color: white;
  background: ${e=>Ul[e.rankColor].background};
  border: 0.15vh solid ${e=>Ul[e.rankColor].color};
  margin-bottom: 0.5vh;

  span.score {
    color: rgba(255,255,255, 0.5);
    font-size: 0.7vw;
  }

  section {
    display: flex;
    align-items: center;
    min-width: 8vw;
    
    span {
      color: white;
      font-size: 0.8vw;
    }
  }

  svg {
    height: 2vh;
    width: 2vh;
    max-height: 1vw;
    margin-right: 1vw;
    fill: ${e=>Ul[e.rankColor].color};
  }
`,Ul={gold:{background:"linear-gradient(90deg, rgba(242,10,69, 0.2) 0%, rgba(242,10,69, 0) 47.66%), linear-gradient(0deg, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), rgba(255, 255, 255, 0.02)",color:"#FFD700"},silver:{background:"linear-gradient(90deg, rgba(192, 192, 192, 0.2) 0%, rgba(192, 192, 192, 0) 50%), linear-gradient(0deg, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), rgba(255, 255, 255, 0.02)",color:"#C0C0C0"},bronze:{background:"linear-gradient(90deg, rgba(205, 127, 50, 0.2) 0%, rgba(50, 217, 107, 0) 50%, rgba(205, 127, 50, 0) 50%), linear-gradient(0deg, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), rgba(255, 255, 255, 0.02)",color:"#CD7F32"},default:{background:"linear-gradient(0deg, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), rgba(255, 255, 255, 0.02)",color:"rgba(0,0,0,0.25)"}};function Y6({name:e,score:t,index:n,...r}){const[i,o]=x.exports.useState("default");return x.exports.useEffect(()=>{switch(n){case 0:o("gold");break;case 1:o("silver");break;case 2:o("bronze");break;default:o("default");break}},[]),v(Q6,{rankColor:i,...r,children:[v("section",{children:[i!=="default"&&a(G6,{}),a("span",{children:e})]}),v("span",{className:"score",children:[t," PONTOS"]})]})}const K6=E.div`
  position: absolute;
  top: 50%;
  right: 2vw;
  transform: translateY(-50%);

  display: flex;
  flex-direction: column;
`;function pf({teams:e,...t}){return a(K6,{...t,children:e.map((n,r)=>a(Y6,{index:r,...n}))})}function Z6(){return a(i4,{children:a(R6,{})})}Wl.createRoot(document.getElementById("root")).render(a(Y.StrictMode,{children:a(Gp,{children:a(Fp,{children:v(k3,{children:[a(Zh,{children:a(Z6,{})}),a(Qp,{})]})})})}));
