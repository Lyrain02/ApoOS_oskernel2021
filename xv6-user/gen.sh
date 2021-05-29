riscv64-unknown-elf-objcopy -S -O binary _init _test
od -t xC _test > init_obj.txt
python3 gen_obj.py > _new_init_obj.txt
