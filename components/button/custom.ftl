<#macro kw component="button" rest...>
  <${component}
    class="flex justify-center px-4 py-2 relative rounded-lg text-sm text-white w-full focus:outline-none focus:ring-2"
    style="border: 2px solid #001259; border-radius: 5px; text-align: center; width: 30%; min-width: 150px;  align-content: right; background-color: transparent; "
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>

