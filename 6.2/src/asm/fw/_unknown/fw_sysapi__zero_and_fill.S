/* fw_sysapi__zero_and_fill @ 0x8f7ffc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysapi__fill_at_3c, fw_sysapi_mgr__start_sysapi_cmd
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi__zero_and_fill
fw_sysapi__zero_and_fill:
	.global L_8f7ffc
L_8f7ffc:
	push_s blink
L_8f7ffe:
	bl.d L_8c01e4
L_8f8002:
	mov_s r1,0x8
L_8f8004:
	mov_s r13,r0
L_8f8006:
	mov_s r14,0x0
L_8f8008:
	bl.d L_8c1cd8
L_8f800c:
	st.ab r14,[r0,0x4]
L_8f8010:
	st_s r14,[r13,0xc]
L_8f8012:
	st_s r14,[r13,0x10]
L_8f8014:
	st_s r14,[r13,0x18]
L_8f8016:
	st_s r14,[r13,0x1c]
L_8f8018:
	st_s r14,[r13,0x20]
L_8f801a:
	st_s r14,[r13,0x24]
L_8f801c:
	st_s r14,[r13,0x28]
L_8f801e:
	st_s r14,[r13,0x2c]
L_8f8020:
	st_s r14,[r13,0x30]
L_8f8022:
	b.d L_8c0254
L_8f8026:
	st_s r14,[r13,0x34]
