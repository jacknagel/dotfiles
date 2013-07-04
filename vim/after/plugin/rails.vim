if !exists("g:rails_projections")
  let g:rails_projections = {}
endif

if !exists("g:rails_gem_projections")
  let g:rails_gem_projections = {}
endif

call extend(g:rails_projections, {
  \ "config/routes.rb": {
  \   "command": "routes"},
  \ }, "keep")

call extend(g:rails_gem_projections, {
  \ "rspec": {
  \  "spec/support/*.rb": {
  \    "command": "support"}},
  \ "cucumber": {
  \   "features/*.feature": {
  \     "command": "feature",
  \     "template": "Feature: %h"},
  \   "features/support/*.rb": {
  \     "command": "support"},
  \   "features/support/env.rb": {
  \     "command": "support"},
  \   "features/step_definitions/*_steps.rb": {
  \     "command": "steps"},
  \   "features/step_definitions/web_steps.rb": {
  \     "command": "steps"}},
  \ "factory_girl": {
  \   "spec/factories/*_factory.rb": {
  \     "command": "factory",
  \     "alternate": "app/models/%s.rb",
  \     "related": "db/schema.rb#%p",
  \     "test": "spec/models/%s_spec.rb",
  \     "template": "FactoryGirl.define do\n  factory :%s do\n  end\nend",
  \     "affinity": "model"},
  \   "spec/factories.rb": {
  \      "command": "factory"}},
  \ }, "keep")
