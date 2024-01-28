#   *   *   *   *   *   *   *   *
# Conda Install
#   -   -   -   -
#   torchvision torchaudio
    # --index-url https://download.pytorch.org/whl/cu123
#RUN conda install python=3.9 pip && \
#    pip --upgrade && \
#    pip install torch=12.3
#pip install torch --index-url https://download.pytorch.org/whl/cu121
#torchvision torchaudio




#   *   *   *   *   *   *   *   *
# NVidia Installs
#   -   -   -   -
#RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
#  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
#    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
#    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list \
#  && \
#    apt-get update && \
#   apt-get install -y nvidia-container-toolkit





#   *   *   *   *   *   *   *   *
# PyEnv Installs
#   -   -   -   -

###ENV HOME  /home/python_user
###ENV PYENV_ROOT $WORKDIR/.pyenv
###ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
