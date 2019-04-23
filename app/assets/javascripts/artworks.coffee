# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  do ->
    replaceSelectOptions = ($select, results) ->
      $select.html $('<option>')
      $.each results, ->
        option = $('<option>').val(this.id).text(this.name)
        $select.append(option)

     replaceChildrenOptions = ->
     # 選択されたクリエイターのオプションから、data-children-pathの値を読み取る
      childrenPath = $(@).find('option:selected').data().childrenPath
      # フォルダのセレクトボックスを取得する
      $selectChildren = $(@).closest('form').find('.select-children')
      if childrenPath?
        # childrenPathが存在する = クリエイターが選択されている場合、
        # ajaxでサーバーにフォルダの一覧を問い合わせる
        $.ajax
          url: childrenPath
          dataType: "json"
          success: (results) ->
            # サーバーから受け取ったフォルダの一覧でセレクトボックスを置き換える
            replaceSelectOptions($selectChildren, results)
          error: (XMLHttpRequest, textStatus, errorThrown) ->
            # 何らかのエラーが発生した場合
            console.error("Error occurred in replaceChildrenOptions")
            console.log("XMLHttpRequest: #{XMLHttpRequest.status}")
            console.log("textStatus: #{textStatus}")
            console.log("errorThrown: #{errorThrown}")

      else
        # クリエイターが未選択だったので、フォルダの選択肢をクリアする
        replaceSelectOptions($selectChildren, [])

    $('.select-parent').on
      # クリエイター変更時のイベントを設定
      'change': replaceChildrenOptions