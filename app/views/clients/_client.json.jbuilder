json.id user.id
json.name user.name
json.projects user.products do |project|
  json.partial! 'projects/project', locals: { project: project }
end
json.employees user.employees do |employee|
  json.partial! 'employees/user', locals: { user: employee }
end