{literal}
  <style>
    table.log tr td {
      padding: 1px 8px; 
      font-family: Courier;
      letter-spacing: -1px;
      font-size: 12px;
      line-height: 1.2em;
      background-color: #f7f7f7;
    }
  </style>
{/literal}
  

<form action="{$url_action}" method="post" name="DataSource" id="DataSource" enctype="multipart/form-data" >
  <div class="crm-block crm-form-block crm-import-datasource-form-block" id="choose-data-source">
    <h3>Select Importer</h3>
    <table class="form-layout">
      <tbody>
        <tr class="crm-import-datasource-form-block-dataSource">
          <td class="label"><label for="dataSource">Choose configuration<span title="This field is required." class="crm-marker">*</span></label>
          </td>
          <td>
            <select class="form-select required" id="banking-importer-plugin" name="importer-plugin" onchange="selected_plugin_changed(this.value);" 
            {if $page_mode == 'run'}disabled{/if}>
              <option value="-9999">-- select --</option>
            {foreach from=$plugin_list item=field key=fieldName}
              <option value="{$field->id}" {if $plugin_id == $field->id} selected{/if}>{$field->name}</option>
            {/foreach}
          </select>
        </td>
      </tr>
      <!--tr class="crm-import-datasource-form-block-dataSource">
        <td class="label"><label for="dataSource">Plugin Configuration<span title="This field is required." class="crm-marker">*</span></label>
        </td>
        <td>
          <select class="form-select required" id="banking-importer-plugin-configuration" name="importer-config" onchange="todo(this.value);" 
    {if $page_mode == 'run'}disabled{/if}>
<option selected="selected" value="Default">Default</option>
</select>
</td>
</tr-->
  </tbody>
</table>
</div>

<div class="crm-block crm-form-block crm-import-datasource-form-block" id="upload_file" style="display: none;">
  <h3>Upload File</h3>
  <table class="form-layout">
    <tbody>
      <tr>
        {if isset($file_info)}
          <td>Processed file "{$file_info.name}"...</td>
        {else}        
          <td class="label">
            <label for="uploadFile">  Import Data File<span title="This field is required." class="crm-marker">*</span></label>
          </td>
          <td>
            <input type="file" class="form-file required" id="uploadFile" name="uploadFile" maxlength="255" size="30" 
                   {if $page_mode == 'run'}
                     disabled
                   {elseif $has_file_source[0] == 'false'}
                     disabled
                   {/if}><br>
          {/if}
        </td>
      </tr>
    </tbody>
  </table>
</div>

<div class="crm-block crm-form-block crm-import-datasource-form-block" id="import options">
  <h3>Import Options</h3>
  <table class="form-layout">
    <tbody>
      <tr class="crm-import-datasource-form-block-dataSource">
        <td>
          <input type="checkbox" class="form-checkbox" value="on" name="dry_run" id="dry_run"
          {if $page_mode == 'run'} disabled {/if}
        {if $dry_run == 'on'} checked {/if}>
      Dry run</input>
    </td>
  </tr>
  <tr class="crm-import-datasource-form-block-dataSource">
    <td>
      <input type="checkbox" class="form-checkbox" value="on" name="process" id="process" 
      {if $page_mode == 'run'} disabled {/if}
    {if $process == 'on'} checked {/if}>
  Process payments right away</input>
</td>
</tr>
</tbody>
</table>
</div>

{if $page_mode == 'run'}
  <div class="crm-block crm-container crm-import-datasource-form-block" id="run_log">
    <h3>Execution log</h3>
    <table class="log">
      {foreach from=$log item=field}
        <tr>
          <td style="white-space: nowrap; background-color: white; color: #ccc;">
            {$field[0]}
          </td>
          <td style="white-space: nowrap;text-align: center;">
            {if $field[1]>0}{$field[1]*100|string_format:"%.2f"} %{/if}
          </td>
          <td width="80%">
            {$field[2]}
          </td>
        </tr>
      {/foreach}
    </table>
  </div>
{/if}


<div class="crm-submit-buttons">
  {if $page_mode == 'config'}
    <span class="crm-button crm-button-type-upload crm-button_qf_DataSource_upload">
      <input type="submit" value="Import!" class="validate form-submit default">
    </span>
  {else}
    <a class="button" href="{$url_payments}">
      <span align="right"><div class="icon details-icon"></div>See Results</span>
    </a>
    <a class="button" href="{$url_action}">
      <span align="right"><div class="icon details-icon"></div>Import More</span>
    </a>
  {/if}
</div>
</form>


<script type="text/javascript">
  {literal} 
    var has_file_source = {
  {/literal}
  {foreach from=$has_file_source item=field key=fieldName}
    {$fieldName} : {$field},
  {/foreach}
  {literal}
    };
  function selected_plugin_changed(new_id) {
    // enable/disable the file input field dending of the selected importer
    if (!has_file_source[new_id]) {
      document.getElementById('uploadFile').disabled = true;
      cj('#upload_file').css('display','none');
    } else {
      cj('#upload_file').css('display','block');
    }
  }
  {/literal} 
</script>