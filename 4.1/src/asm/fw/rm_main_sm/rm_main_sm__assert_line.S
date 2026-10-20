/* rm_main_sm__assert_line @ 0x8e0374, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm.cpp
 * Зовут его: radio_manager_main_sm__on_sec_tune
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.rm_main_sm__assert_line,"ax",@progbits
	.global rm_main_sm__assert_line
rm_main_sm__assert_line:
	.global L_8e0374
L_8e0374:
	mov_s r0,blink
L_8e0376:
	mov_s r2,0x1015d54
L_8e037c:
	mov_s r1,0x1177
L_8e0382:
	bl.d L_8c82c0
L_8e0386:
	mov r3,0x234
L_8e038a:
	/* b_s 0x008e0362 */
	.byte 0xed,0xf1
