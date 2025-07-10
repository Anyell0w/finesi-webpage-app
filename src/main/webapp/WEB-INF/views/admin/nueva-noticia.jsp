<!-- admin/nueva-noticia.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/views/includes/header.jsp">
    <jsp:param name="title" value="Nueva Noticia" />
</jsp:include>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1><i class="bi bi-newspaper me-2"></i>Nueva Noticia</h1>
        <a href="<%=request.getContextPath()%>/admin" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left me-2"></i>Volver al Panel
        </a>
    </div>
    
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i><%=request.getAttribute("error")%>
        </div>
    <% } %>
    
    <div class="card">
        <div class="card-body">
            <form method="post" action="<%=request.getContextPath()%>/admin">
                <input type="hidden" name="action" value="crear-noticia">
                
                <div class="mb-3">
                    <label class="form-label">Título *</label>
                    <input type="text" name="titulo" class="form-control" required maxlength="200">
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Resumen *</label>
                    <textarea name="resumen" class="form-control" rows="3" required maxlength="500" 
                              placeholder="Breve descripción de la noticia..."></textarea>
                    <div class="form-text">Máximo 500 caracteres</div>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Contenido *</label>
                    <textarea  id="editor" name="contenido" class="form-control" rows="8" required 
                              placeholder="Contenido completo de la noticia..."></textarea>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">URL de Imagen</label>
                    <input type="url" name="imagenUrl" class="form-control" maxlength="255"
                           placeholder="https://ejemplo.com/imagen.jpg">
                    <div class="form-text">URL de una imagen para acompañar la noticia (opcional)</div>
                </div>
                
                <div class="d-flex justify-content-end gap-2">
                    <a href="<%=request.getContextPath()%>/admin" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-save me-2"></i>Crear Noticia
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>


<script src="https://cdn.ckeditor.com/ckeditor5/41.1.0/classic/ckeditor.js"></script>
<script>
    let editorInstance;

    ClassicEditor
        .create(document.querySelector('#editor'))
        .then(editor => {
            editorInstance = editor;
        })
        .catch(error => {
            console.error(error);
        });

    // Convertir HTML a texto plano al enviar el formulario
    document.querySelector('form').addEventListener('submit', function (e) {
        if (editorInstance) {
            const htmlContent = editorInstance.getData();

            // Convertir HTML a texto plano usando un contenedor temporal
            const tempDiv = document.createElement('div');
            tempDiv.innerHTML = htmlContent;
            const plainText = tempDiv.textContent || tempDiv.innerText || "";

            // Reemplazar el contenido del textarea con el texto plano
            document.querySelector('#editor').value = plainText;
        }
    });
</script>
<jsp:include page="/WEB-INF/views/includes/footer.jsp" />