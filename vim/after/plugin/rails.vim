" autocmd User Rails Rnavcommand factory spec/factories -glob=**/* -suffix=_factory.rb -default=model()
" autocmd User Rails Rnavcommand feature features -glob=**/* -suffix=.feature
" autocmd User Rails Rnavcommand steps features/step_definitions spec/steps -glob=**/* -suffix=_steps.rb -default=web
" autocmd User Rails Rnavcommand support spec/support features/support -default=env
" autocmd User Rails command! Rroutes e config/routes.rb
