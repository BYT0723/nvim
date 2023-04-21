local fn = vim.fn

local mode2IM = {
  normal = 'keyboard-us',
  insert = '',
}

function InsertEnter()
  if mode2IM.insert == '' then
    mode2IM.insert = mode2IM.normal
  end
  fn.jobstart('fcitx5-remote -s ' .. mode2IM.insert)
end

function InsertLeavePre()
  fn.jobstart('fcitx5-remote -n', {
    on_stdout = function(_, data, _)
      mode2IM.insert = data
    end,
  })

  fn.jobstart('fcitx5-remote -s ' .. mode2IM.normal)
end
