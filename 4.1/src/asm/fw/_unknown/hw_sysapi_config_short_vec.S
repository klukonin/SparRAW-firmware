/* hw_sysapi_config_short_vec @ 0x8cb714, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_sysapi_config_short_vec
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, mid__state_is_2_or_3, regulatory_domain_set_tx_gain_offset
 * Глобалы (через gp): 0x8002d0
 */
	.section .text.hw_sysapi_config_short_vec,"ax",@progbits
	.global hw_sysapi_config_short_vec
hw_sysapi_config_short_vec:
	.global L_8cb714
L_8cb714:
	push_s blink
L_8cb716:
	push_s r13
L_8cb718:
	mov_s r2,0x1016788
L_8cb71e:
	mov_s r0,0x5
L_8cb720:
	bl.d L_8edfb0
L_8cb724:
	mov_s r1,0x2
L_8cb726:
	mov_s r13,0x1
L_8cb728:
	st.as r13,[gp,0x58]
L_8cb72c:
	mov r0,0x3e8
L_8cb730:
	mov_s r1,0x857280
L_8cb736:
	st_s r0,[r1,0x1c]
L_8cb738:
	st_s r13,[r1,0x24]
L_8cb73a:
	mov_s r0,0x6
L_8cb73c:
	st_s r0,[r1,0x20]
L_8cb73e:
	bl.d L_8d73c4
L_8cb742:
	mov_s r0,0x0
L_8cb744:
	cmp_s r0,0x1
L_8cb746:
	bl.eq.d L_8de11c
L_8cb74a:
	mov.eq r0,r13
L_8cb74e:
	b.d L_8c033c
L_8cb752:
	mov_s r0,0x1
