<#import "template.ftl" as layout>
<@layout.info displayMessage=false; section>
    <#if section = "header">
        <#if messageHeader??>
        ${messageHeader}
        <#else>
        ${message.summary}
        </#if>
    <#elseif section = "form">
    <div id="kc-info-message" class="no-form-wrapper">

         <h1 style="color: #001259; font:Century Gothic;text-align: left;"> ${message.summary} </h1>
                        
        <h2 style="color: #001259; font:Century Gothic;text-align: left;">  <a href="https://studioin.cloud"> Back to Login !</a> </h2>

    </div>
    </#if>
</@layout.info>